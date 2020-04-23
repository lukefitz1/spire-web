class GeneralInformation < ApplicationRecord
	# has_many :artworks
	has_and_belongs_to_many :artworks

	default_scope { order(information_label: :asc) }
end
