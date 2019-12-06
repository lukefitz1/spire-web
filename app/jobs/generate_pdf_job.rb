class GeneratePdfJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @artwork = args[0]
    timestamp = args[1]
    bucket_name = args[2]
    temp_art_name = args[3]
    art_file_name = args[4]
    @additional_pdf_found = args[5]
    collection_id = args[6]
    puts "Bucket name: #{bucket_name}"
    puts "Is there an additional PDF: #{@additional_pdf_found}"
    client = Pdfcrowd::PdfToPdfClient.new('spireart', '4ca5bdb67c50b7a3ca5d9a207de070e0')

    s3 = Aws::S3::Client.new(region: ENV.fetch('AWS_REGION'),
                             access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
                             secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'))

    # create an instance of ActionView, so we can use the render method outside of a controller
    av = ActionView::Base.new()
    av.view_paths = ActionController::Base.view_paths

    # need these in case your view constructs any links or references any helper methods.
    av.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
    end

    # Here is where we start combining the additional PDF with the generated catalog page
    if @artwork[:additionalPdf] || @additional_pdf_found
      # generate that PDF
      pdf_html = av.render :template => 'artworks/preview_pdf.pdf.erb', :layout => nil, :locals => {:artwork => @artwork}
      doc_pdf = WickedPdf.new.pdf_from_string(pdf_html, :page_size => 'Letter')

      # saving PDF to disk
      pdf_path = Rails.root.join('tmp', temp_art_name)
      File.open(pdf_path, 'wb') do |file|
        file << doc_pdf
      end

      if @artwork[:additionalPdf]
        puts 'We found an additional PDF file associated with the individual piece of art'
        url = "https://#{ENV["S3_BUCKET"]}.s3.amazonaws.com/uploads/artwork/additionalPdf/#{@artwork[:id]}/#{@artwork[:additionalPdf]}"
      elsif @additional_pdf_found
        puts 'We found an additional PDF file uploaded via the collection'
        url = "https://#{ENV["S3_BUCKET"]}.s3.amazonaws.com/uploads/collection/files/#{collection_id}/#{@artwork.ojbId}_PDF.pdf"
      end

      open(Rails.root.join("tmp", "crossing_fingers.pdf"), "wb") do |file|
        file << open(url).read

        open(Rails.root.join("tmp", "template.pdf"), "wb") do |file2|
          file2 << open(Rails.root.join("tmp", temp_art_name)).read
        end
      end

      # combine files
      client.addPdfFile(Rails.root.join("tmp", "template.pdf"))
      client.addPdfFile(Rails.root.join("tmp", "crossing_fingers.pdf"))

      # run the conversion and write the result to a file
      client.convertToFile("#{Rails.root}/tmp/#{@artwork.ojbId} #{@artwork.artist.firstName} #{@artwork.artist.lastName} (#{@artwork.title}) - #{@artwork.currentLocation}.pdf")

      # clean up some files
      File.delete("#{Rails.root}/tmp/template.pdf") if File.exist?("#{Rails.root}/tmp/template.pdf")
      File.delete("#{Rails.root}/tmp/crossing_fingers.pdf") if File.exist?("#{Rails.root}/tmp/crossing_fingers.pdf")
    else
      # generate that PDF
      puts 'No additional PDFs were found for this piece of art, Hooray!'
      pdf_html = av.render :template => 'artworks/preview_pdf.pdf.erb', :layout => nil, :locals => {:artwork => @artwork}
      doc_pdf = WickedPdf.new.pdf_from_string(pdf_html, :page_size => 'Letter')

      # saving PDF to disk
      pdf_path = Rails.root.join('tmp', "#{Rails.root}/tmp/#{@artwork.ojbId} #{@artwork.artist.firstName} #{@artwork.artist.lastName} (#{@artwork.title}) - #{@artwork.currentLocation}.pdf")
      File.open(pdf_path, 'wb') do |file|
        file << doc_pdf
      end
    end

    puts "Deleting temp_art_name file"
    File.delete("#{Rails.root}/tmp/#{temp_art_name}") if File.exist?("#{Rails.root}/tmp/#{temp_art_name}")

    ## upload pdf to S3
    File.open("#{Rails.root}/tmp/#{art_file_name}", "r") do |final_pdf|
      s3.put_object(bucket: bucket_name, key: art_file_name, body: final_pdf)
    end
  end
end
