Rails.application.routes.draw do
  scope(path: "/findingaids") do
    concern :range_searchable, BlacklightRangeLimit::Routes::RangeSearchable.new
    mount Blacklight::Engine => "/"
    mount Arclight::Engine => "/"

    root to: "catalog#index"
    concern :searchable, Blacklight::Routes::Searchable.new

    resource :catalog, only: [:index], as: "catalog", path: "/catalog", controller: "catalog" do
      concerns :searchable
      concerns :range_searchable
    end

    devise_for :users, controllers: {
      sessions: "users/sessions"
    }

    concern :exportable, Blacklight::Routes::Exportable.new

    resources :solr_documents, only: [:show], path: "/catalog", controller: "catalog" do
      concerns :exportable
    end

    resources :bookmarks do
      concerns :exportable

      collection do
        delete "clear"
      end
    end
  end

  get "/", controller: :catalog, action: :index
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
