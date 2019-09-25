require "administrate/base_dashboard"

class CollectionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    artworks: Field::HasMany,
    visits: Field::HasMany,
    customer: Field::BelongsTo,
    id: Field::String.with_options(searchable: false),
    collectionName: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    identifier: Field::String,
    year: Field::String,
    customer_proposals: Field::String,
    customer_invoices: Field::String,
    additional_photos: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  artworks
  visits
  customer
  id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  artworks
  visits
  customer
  id
  collectionName
  created_at
  updated_at
  identifier
  year
  customer_proposals
  customer_invoices
  additional_photos
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  artworks
  visits
  customer
  collectionName
  identifier
  year
  customer_proposals
  customer_invoices
  additional_photos
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

  # Overwrite this method to customize how collections are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(collection)
  #   "Collection ##{collection.id}"
  # end
end
