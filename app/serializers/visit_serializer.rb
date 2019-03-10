class VisitSerializer < ActiveModel::Serializer
  attributes :id, :visit_notes, :visit_date_start, :visit_date_end
end
