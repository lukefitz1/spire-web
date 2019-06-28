class Medium < ApplicationRecord
    mount_uploader :media_name, ImageUploader

    belongs_to :customer, optional: true
end
