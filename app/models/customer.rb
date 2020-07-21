class Customer < ApplicationRecord
  require 'csv'

  has_many :artworks, dependent: :nullify
  has_many :collections, dependent: :nullify
  has_many :media, dependent: :nullify

  mount_uploaders :customer_photos, ImageUploader

  def self.import(file)
    # loops through csv data
    CSV.foreach(file.path, headers:true) do |row|
      # create new artwork
      Customer.create! row.to_hash
    end
  end
end
