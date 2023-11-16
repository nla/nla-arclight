Rails.application.routes.draw do
  scope(path: "/finding-aids") do
    mount Blacklight::Engine => "/"
    mount Arclight::Engine => "/"
    mount Yabeda::Prometheus::Exporter => "/metrics"

    concern :searchable, Blacklight::Routes::Searchable.new
    concern :exportable, Blacklight::Routes::Exportable.new
    concern :hierarchy, Arclight::Routes::Hierarchy.new

    resource :catalog, only: [:index], as: "catalog", path: "/catalog", controller: "catalog" do
      concerns :searchable
    end

    resources :solr_documents, only: [:show], path: "/catalog", controller: "catalog" do
      concerns :hierarchy
      concerns :exportable
    end

    resources :bookmarks do
      concerns :exportable

      collection do
        delete "clear"
      end
    end

    # Show repostories with information about each
    # root to: "arclight/repositories#index"

    # Show first 100 NLA collections
    # root to: "arclight/repositories#show", id: "nla"

    # Show search for NLA collections
    root to: "catalog#index", defaults: {f: {level: ["Collection"], repository: ["National Library of Australia"]}}
  end

  get "/", to: redirect("/finding-aids")
end
