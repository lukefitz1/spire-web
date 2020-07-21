class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :firstName, :lastName, :email_address, :phone_number, :street_address, :city, :state, :zip, :referred_by, :project_notes, :collections

  def collections
    object.collections.map do |collection|
      {
        id: collection.id,
        created_at: collection.created_at,
        updated_at: collection.updated_at
      }
    end
  end
end
