class Visit < ApplicationRecord
	belongs_to :collection, optional: true
end
