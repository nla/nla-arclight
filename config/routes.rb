Rails.application.routes.draw do
  scope(path: "/finding-aids") do
    mount Blacklight::Engine => "/"
    mount Yabeda::Prometheus::Exporter => "/metrics"

    root to: "catalog#index"
    concern :searchable, Blacklight::Routes::Searchable.new

    resource :catalog, only: [:index], as: "catalog", path: "/catalog", controller: "catalog" do
      concerns :searchable
    end

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
end
