class Artist < ApplicationRecord
  require "csv"

  default_scope { order(firstName: :asc) }

  # has_many :artworks
  has_and_belongs_to_many :artworks, dependent: :nullify

  mount_base64_uploader :artist_image, ImageUploader

  def self.import(file)
    # loops through csv data
    CSV.foreach(file.path, headers: true) do |row|
      Artist.create! row.to_hash
    end
  end

  def self.to_csv
    attributes = %w[firstName lastName additionalInfo biography]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |artist|
        csv << attributes.map { |attr| artist.send(attr) }
      end
    end
  end
end
