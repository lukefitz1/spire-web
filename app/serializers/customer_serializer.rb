class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :firstName, :lastName, :email_address, :phone_number, :street_address, :city, :state, :zip, :referred_by, :project_notes

  has_many :collections
  has_many :artworks
end
