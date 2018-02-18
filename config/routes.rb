Rails.application.routes.draw do
  
    # for the api calls
	namespace :api, :defaults => {:format => :json} do
		as :user do
		  post   "/sign-in"       => "sessions#create"
		  delete "/sign-out"      => "sessions#destroy"

		  # customers api route
		  resources :customer

		  # artist api route
		  resources :artist

		  # artwork api route
		  resources :artwork

		  # collection api route
		  resources :collections
		end
	end

	devise_for :users#, skip: [:registrations]

	authenticate :user do
	  root to: 'customers#index', as: :authenticated_root
	  
	  get '/artworks/import', to: "artworks#import", as: "import"
	  get '/artists/import_artists', to: "artists#import_artists", as: "import_artists"
	  get '/customers/import_customers', to: "customers#import_customers", as: "import_customers"
	  get '/artworks/preview_pdf/:id', to: "artworks#preview_pdf", as: "preview_pdf"
	  get '/collections/new_from_customer', to: 'collections#new', as: 'new_from_customer'
	  get '/artworks/new_from_collection', to: 'artworks#new', as: 'new_from_collection'
	  get '/artworks/fancy_report/:id', to: "artworks#fancy_report", as: "fancy_report"

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

	end

	root to: redirect('/users/sign_in')

end
