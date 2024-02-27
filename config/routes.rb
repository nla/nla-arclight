require "nla/routes"

Rails.application.routes.draw do
  scope(path: "/finding-aids") do
    mount Blacklight::Engine => "/"
    mount Arclight::Engine => "/"
    mount Yabeda::Prometheus::Exporter => "/metrics"

    concern :searchable, Blacklight::Routes::Searchable.new
    concern :exportable, Blacklight::Routes::Exportable.new
    concern :hierarchy, Arclight::Routes::Hierarchy.new
    concern :range_searchable, BlacklightRangeLimit::Routes::RangeSearchable.new
    concern :iiif, Nla::Routes::Iiif.new

    resource :catalog, only: [:index], as: "catalog", path: "/catalog", controller: "catalog" do
      concerns :searchable
      concerns :range_searchable
    end

    resources :solr_documents, only: [:show], path: "/catalog", controller: "catalog" do
      concerns :hierarchy
      concerns :exportable
      concerns :iiif
    end

    resources :bookmarks do
      concerns :exportable

      collection do
        delete "clear"
      end
    end

    # error handlers
    get "/404", to: "errors#not_found", as: "not_found_error", via: :all
    get "/422", to: "errors#unprocessable", as: "unprocessable_error", via: :all
    get "/500", to: "errors#internal_server", as: "internal_server_error", via: :all
    get "/503", to: "errors#unavailable", as: "unavailable_error", via: :all

    # Show repostories with information about each
    # root to: "arclight/repositories#index"

    # Show first 100 NLA collections
    # root to: "arclight/repositories#show", id: "nla"

    # Show search for NLA collections
    root to: "catalog#index", defaults: {f: {level: ["Collection"], repository: ["National Library of Australia"]}}
  end

  get "/", to: redirect("/finding-aids")
end
