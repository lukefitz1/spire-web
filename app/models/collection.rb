class Collection < ApplicationRecord
  has_many :artworks
  belongs_to :customer, optional: true
end
