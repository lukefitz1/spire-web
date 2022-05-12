Rails.application.routes.draw do
  # devise_for :users, skip: [:registrations]

  root "customers#index"

  get "/dashboard" => "dashboard#show"
  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/auth/logout" => "auth0#logout"
  get "/auth/redirect" => "auth0#redirect"

  # authenticate :user do
  #   root to: "customers#index", as: :authenticated_root

    get "/general_informations/search", to: "general_informations#search",  as: "general_information_search"
    get "/artists/search",              to: "artists#search",               as: "artist_search"
    get "/artworks/search",             to: "artworks#search",              as: "artwork_search"
    get "/artworks/sort_table", to: "artworks#sort_table", as: "sort_table"
    get "/artworks/import", to: "artworks#import", as: "import"
    get "/artists/import_artists", to: "artists#import_artists", as: "import_artists"
    get "/customers/import_customers", to: "customers#import_customers", as: "import_customers"
    get "/artworks/preview_pdf/:id", to: "artworks#preview_pdf", as: "preview_pdf"
    get "/collections/new_from_customer", to: "collections#new", as: "new_from_customer"
    get "/artworks/new_from_customer_collection", to: "artworks#new", as: "new_from_customer_collection"
    get "/artworks/new_from_collection", to: "artworks#new", as: "new_from_collection"
    get "/artworks/fancy_report/:id", to: "artworks#fancy_report", as: "fancy_report"
    get "/artworks/preview_html/:id", to: "artworks#preview_html", as: "preview_html"
    get "/collections/preview_table/:id", to: "collections#preview_table", as: "preview_table"
    get "/collections/pdf_table/:id", to: "collections#pdf_table", as: "pdf_table"
    get "/collections/send_that_file", to: "collections#send_that_file", as: "send_that_file"
    get "/artworks/search_by_objid", to: "artworks#search_by_objid"
    get "/collections/download_pdf_table/:id", to: "collections#download_pdf_table", as: "download_pdf_table"
    get "/visits/new", to: "visits#new", as: "new_visit_from_collection"
    get "/collections/table_of_contents/:id", to: "collections#table_of_contents", as: "table_of_contents"
    get "/collections/table_of_contents_pdf/:id", to: "collections#table_of_contents_pdf", as: "table_of_contents_pdf"
    get "/collections/toc_book/:id", to: "collections#toc_book", as: "toc_book"
    get "/collections/toc_book_pdf/:id", to: "collections#toc_book_pdf", as: "toc_book_pdf"
    post "/artists/ajax_create", to: "artists#ajax_create", as: "ajax_create"
    post "/general_informations/ajax_create", to: "general_informations#ajax_create", as: "gi_ajax_create"
    delete "artworks/destroy_multiple", to: "artworks#destroy_multiple"
    delete "artists/destroy_multiple", to: "artists#destroy_multiple"
    post "/collections/remove_photos", to: "collections#remove_photos", as: "remove_photos"
    get "/artworks/download_pdfs/:id", to: "artworks#download_pdfs", as: "download_pdfs"
    get "/artworks/download_pdfs_background/:id", to: "artworks#download_pdfs_background", as: "download_pdfs_background"
    post "/collections/get_bucket_status", to: "collections#get_bucket_status", as: "get_bucket_status"
    get "/collections/download_pdfs_s3", to: "collections#download_pdfs_s3", as: "download_pdfs_s3"
    put "/artworks/update_object_id", to: "artworks#update_object_id"
    get "/artists/export_csv", to: "artists#export_csv", as: "export_csv"

    resources :general_informations
    resources :media
    resources :visits

    resources :artworks do
      collection { post :import }
    end

    resources :artists do
      collection { post :import_artists }
    end

    resources :customers do
      collection { post :import_customers }
    end

    resources :collections do
    end
  # end

  # root to: redirect('/users/sign_in')

  namespace :api, defaults: {format: :json} do
    # mount_devise_token_auth_for 'User', at: 'auth'

    # as :user do
      # post '/sign-in' => 'sessions#create'
      # delete '/sign-out' => 'sessions#destroy'

    resources :customer
    resources :artist
    resources :artwork
    resources :collections
    resources :media
    resources :general_informations
    resources :visits
    # end
  end

  # namespace :admin do
  #   resources :users
  #   resources :artists
  #   resources :artworks
  #   resources :collections
  #   resources :customers
  #   resources :general_informations
  #   resources :media
  #   resources :visits
  #   resources :admin_users
  #
  #   root to: "users#index"
  # end
end
