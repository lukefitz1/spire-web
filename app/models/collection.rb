class Collection < ApplicationRecord
  has_many :artworks, dependent: :nullify
  has_many :visits

  belongs_to :customer, optional: true

  mount_uploaders :customer_proposals, PdfUploader
  mount_uploaders :customer_invoices, PdfUploader
  mount_uploaders :additional_photos, ImageUploader
  mount_uploaders :files, MultiImageUploader
end
