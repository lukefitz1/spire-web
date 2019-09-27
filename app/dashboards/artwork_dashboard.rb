require "administrate/base_dashboard"

class ArtworkDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    artist: Field::BelongsTo,
    customer: Field::BelongsTo,
    collection: Field::BelongsTo,
    general_information: Field::BelongsTo,
    id: Field::String.with_options(searchable: false),
    ojbId: Field::String,
    artType: Field::String,
    title: Field::String,
    date: Field::String,
    medium: Field::String,
    image: Field::String,
    description: Field::Text,
    dimensions: Field::String,
    frame_dimensions: Field::String,
    condition: Field::String,
    currentLocation: Field::String,
    source: Field::String,
    dateAcquired: Field::String,
    amountPaid: Field::String,
    currentValue: Field::String,
    notes: Field::Text,
    notesImage: Field::String,
    additionalInfoLabel: Field::String,
    additionalInfoText: Field::Text,
    additionalInfoImage: Field::String,
    additionalPdf: Field::String,
    reviewedBy: Field::String,
    reviewedDate: Field::String,
    provenance: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    dateAcquiredLabel: Field::String,
    notesImageTwo: Field::String,
    additionalInfoImageTwo: Field::String,
    show_general_info: Field::Boolean,
    custom_title: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  artist
  customer
  collection
  general_information
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  artist
  customer
  collection
  general_information
  id
  ojbId
  artType
  title
  date
  medium
  image
  description
  dimensions
  frame_dimensions
  condition
  currentLocation
  source
  dateAcquired
  amountPaid
  currentValue
  notes
  notesImage
  additionalInfoLabel
  additionalInfoText
  additionalInfoImage
  additionalPdf
  reviewedBy
  reviewedDate
  provenance
  created_at
  updated_at
  dateAcquiredLabel
  notesImageTwo
  additionalInfoImageTwo
  show_general_info
  custom_title
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  artist
  customer
  collection
  general_information
  ojbId
  artType
  title
  date
  medium
  image
  description
  dimensions
  frame_dimensions
  condition
  currentLocation
  source
  dateAcquired
  amountPaid
  currentValue
  notes
  notesImage
  additionalInfoLabel
  additionalInfoText
  additionalInfoImage
  additionalPdf
  reviewedBy
  reviewedDate
  provenance
  dateAcquiredLabel
  notesImageTwo
  additionalInfoImageTwo
  show_general_info
  custom_title
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

  # Overwrite this method to customize how artworks are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(artwork)
  #   "Artwork ##{artwork.id}"
  # end
end
