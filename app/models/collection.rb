class Collection < ApplicationRecord
  has_many :artworks
  has_many :visits
  
  belongs_to :customer, optional: true
end
