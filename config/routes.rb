# == Route Map
#
#                                   Prefix Verb     URI Pattern                                           Controller#Action
#                               blacklight          /finding-aids                                         Blacklight::Engine
#                          arclight_engine          /finding-aids                                         Arclight::Engine
#               yabeda_prometheus_exporter          /finding-aids/metrics                                 Yabeda::Prometheus::Exporter
#                           search_catalog GET|POST /finding-aids/catalog(.:format)                       catalog#index
#                  advanced_search_catalog GET      /finding-aids/catalog/advanced(.:format)              catalog#advanced_search
#                       page_links_catalog GET      /finding-aids/catalog/page_links(.:format)            catalog#page_links
#                            track_catalog POST     /finding-aids/catalog/:id/track(.:format)             catalog#track
#                              raw_catalog GET      /finding-aids/catalog/:id/raw(.:format)               catalog#raw {:format=>"json"}
#                       opensearch_catalog GET      /finding-aids/catalog/opensearch(.:format)            catalog#opensearch
#                    suggest_index_catalog GET      /finding-aids/catalog/suggest(.:format)               catalog#suggest
#                            facet_catalog GET      /finding-aids/catalog/facet/:id(.:format)             catalog#facet
#                      range_limit_catalog GET      /finding-aids/catalog/range_limit(.:format)           catalog#range_limit
#                                          GET      /finding-aids/catalog/range_limit_panel/:id(.:format) catalog#range_limit_panel
#                  hierarchy_solr_document GET      /finding-aids/catalog/:id/hierarchy(.:format)         catalog#hierarchy
#                      email_solr_document GET|POST /finding-aids/catalog/:id/email(.:format)             catalog#email
#                        sms_solr_document GET|POST /finding-aids/catalog/:id/sms(.:format)               catalog#sms
#                   citation_solr_document GET      /finding-aids/catalog/:id/citation(.:format)          catalog#citation
#                     email_solr_documents GET|POST /finding-aids/catalog/email(.:format)                 catalog#email
#                       sms_solr_documents GET|POST /finding-aids/catalog/sms(.:format)                   catalog#sms
#                  citation_solr_documents GET      /finding-aids/catalog/citation(.:format)              catalog#citation
#                            solr_document GET      /finding-aids/catalog/:id(.:format)                   catalog#show
#                           email_bookmark GET|POST /finding-aids/bookmarks/:id/email(.:format)           bookmarks#email
#                             sms_bookmark GET|POST /finding-aids/bookmarks/:id/sms(.:format)             bookmarks#sms
#                        citation_bookmark GET      /finding-aids/bookmarks/:id/citation(.:format)        bookmarks#citation
#                          email_bookmarks GET|POST /finding-aids/bookmarks/email(.:format)               bookmarks#email
#                            sms_bookmarks GET|POST /finding-aids/bookmarks/sms(.:format)                 bookmarks#sms
#                       citation_bookmarks GET      /finding-aids/bookmarks/citation(.:format)            bookmarks#citation
#                          clear_bookmarks DELETE   /finding-aids/bookmarks/clear(.:format)               bookmarks#clear
#                                bookmarks GET      /finding-aids/bookmarks(.:format)                     bookmarks#index
#                                          POST     /finding-aids/bookmarks(.:format)                     bookmarks#create
#                             new_bookmark GET      /finding-aids/bookmarks/new(.:format)                 bookmarks#new
#                            edit_bookmark GET      /finding-aids/bookmarks/:id/edit(.:format)            bookmarks#edit
#                                 bookmark GET      /finding-aids/bookmarks/:id(.:format)                 bookmarks#show
#                                          PATCH    /finding-aids/bookmarks/:id(.:format)                 bookmarks#update
#                                          PUT      /finding-aids/bookmarks/:id(.:format)                 bookmarks#update
#                                          DELETE   /finding-aids/bookmarks/:id(.:format)                 bookmarks#destroy
#                         email_2fa_enable GET      /finding-aids/email_2fa/enable(.:format)              email2fa#enable
#                        email_2fa_disable GET      /finding-aids/email_2fa/disable(.:format)             email2fa#disable
#                          email_2fa_alert GET      /finding-aids/email_2fa/alert(.:format)               email2fa_alert#show
#                  email_2fa_alert_dismiss GET      /finding-aids/email_2fa/alert/dismiss(.:format)       email2fa_alert#dismiss
#                                     root GET      /finding-aids(.:format)                               catalog#index {:f=>{:level=>["Collection"], :repository=>["National Library of Australia"]}}
#                                          GET      /                                                     redirect(301, /finding-aids)
# user_catalogue_patron_omniauth_authorize GET|POST /users/auth/catalogue_patron(.:format)                users/omniauth_callbacks#passthru
#  user_catalogue_patron_omniauth_callback GET|POST /users/auth/catalogue_patron/callback(.:format)       users/omniauth_callbacks#catalogue_patron
#    user_catalogue_sol_omniauth_authorize GET|POST /users/auth/catalogue_sol(.:format)                   users/omniauth_callbacks#passthru
#     user_catalogue_sol_omniauth_callback GET|POST /users/auth/catalogue_sol/callback(.:format)          users/omniauth_callbacks#catalogue_sol
#    user_catalogue_spl_omniauth_authorize GET|POST /users/auth/catalogue_spl(.:format)                   users/omniauth_callbacks#passthru
#     user_catalogue_spl_omniauth_callback GET|POST /users/auth/catalogue_spl/callback(.:format)          users/omniauth_callbacks#catalogue_spl
# user_catalogue_shared_omniauth_authorize GET|POST /users/auth/catalogue_shared(.:format)                users/omniauth_callbacks#passthru
#  user_catalogue_shared_omniauth_callback GET|POST /users/auth/catalogue_shared/callback(.:format)       users/omniauth_callbacks#catalogue_shared
#                         new_user_session GET      /sign_in(.:format)                                    users/sessions#new
#                     destroy_user_session DELETE   /sign_out(.:format)                                   users/sessions#destroy
#                                   logout GET      /logout(.:format)                                     users/sessions#destroy
#                  expired_keycloak_logout GET      /expired_keycloak_logout(.:format)                    users/sessions#expired_keycloak_logout
#                       backchannel_logout POST     /backchannel_logout(.:format)                         users/sessions#backchannel_logout
#         turbo_recede_historical_location GET      /recede_historical_location(.:format)                 turbo/native/navigation#recede
#         turbo_resume_historical_location GET      /resume_historical_location(.:format)                 turbo/native/navigation#resume
#        turbo_refresh_historical_location GET      /refresh_historical_location(.:format)                turbo/native/navigation#refresh
#
# Routes for Blacklight::Engine:
#       search_history GET    /search_history(.:format)       search_history#index
# clear_search_history DELETE /search_history/clear(.:format) search_history#clear
#
# Routes for Arclight::Engine:
#  collections GET  /collections(.:format)      catalog#index {:f=>{:level=>["Collection"]}}
# repositories GET  /repositories(.:format)     arclight/repositories#index
#   repository GET  /repositories/:id(.:format) arclight/repositories#show

Rails.application.routes.draw do
  scope(path: "/finding-aids") do
    mount Blacklight::Engine => "/"
    mount Arclight::Engine => "/"
    mount Yabeda::Prometheus::Exporter => "/metrics"

    concern :searchable, Blacklight::Routes::Searchable.new
    concern :exportable, Blacklight::Routes::Exportable.new
    concern :hierarchy, Arclight::Routes::Hierarchy.new
    concern :range_searchable, BlacklightRangeLimit::Routes::RangeSearchable.new
    concern :email2fa, Nla::BlacklightCommon::Routes::Email2fa.new

    resource :catalog, as: "catalog", path: "/catalog", controller: "catalog" do
      concerns :searchable
      concerns :range_searchable
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

    concerns :email2fa

    # Show repostories with information about each
    # root to: "arclight/repositories#index"

    # Show first 100 NLA collections
    # root to: "arclight/repositories#show", id: "nla"

    # Show search for NLA collections
    root to: "catalog#index", defaults: {f: {level: ["Collection"], repository: ["National Library of Australia"]}}
  end

  get "/", to: redirect("/finding-aids")
end
