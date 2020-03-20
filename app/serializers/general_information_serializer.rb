class GeneralInformationSerializer < ActiveModel::Serializer
  attributes :id, :information_label, :information, :created_at, :updated_at
end
