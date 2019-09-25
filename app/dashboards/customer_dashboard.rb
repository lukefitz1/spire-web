require "administrate/base_dashboard"

class CustomerDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    artworks: Field::HasMany,
    collections: Field::HasMany,
    media: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    firstName: Field::String,
    lastName: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    email_address: Field::String,
    phone_number: Field::String,
    street_address: Field::String,
    city: Field::String,
    state: Field::String,
    zip: Field::String,
    referred_by: Field::String,
    project_notes: Field::Text,
    customer_photos: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  artworks
  collections
  media
  id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  artworks
  collections
  media
  id
  firstName
  lastName
  created_at
  updated_at
  email_address
  phone_number
  street_address
  city
  state
  zip
  referred_by
  project_notes
  customer_photos
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  artworks
  collections
  media
  firstName
  lastName
  email_address
  phone_number
  street_address
  city
  state
  zip
  referred_by
  project_notes
  customer_photos
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how customers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(customer)
  #   "Customer ##{customer.id}"
  # end
end
