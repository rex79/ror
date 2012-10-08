InternalConsulting::Application.routes.draw do

  namespace :admin do
    root :to => "home#index"

    resources :sessions, only: [:create, :destroy]
    resources :static_pages, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :servizis
    resources :media, only: [:index, :create, :destroy]
    resource  :home

    match '/main',      to: 'home#main'
    match '/signin',    to: "sessions#new"
    match '/signout',   to: "sessions#destroy", via: :delete

    match '/static_pages/addmoduli/:id',    to: "static_pages#addmoduli"
    match '/static_pages/savemoduli',   to: "static_pages#savemoduli", via: :post
    match '/static_pages/updateorder',      to: "static_pages#updateorder"


    match '/servizis/deleteall',  to: "servizis#deleteall", via: :post

    # custom routes for mods management
    # category and sub-category management
    match '/mods',                to: "mods#index"
    match '/mods/addcat',         to: "mods#addcat"
    match '/mods/createcat',      to: "mods#createcat",     via: :post
    match '/mods/editcat',        to: "mods#editcat"
    match '/mods/updatecat',      to: "mods#updatecat",     via: :post
    match '/mods/destroycat',     to: "mods#destroycat",    via: :delete
    match '/mods/deleteallcat',   to: "mods#deleteallcat",  via: :post
    match '/mods/publishedcat',   to: "mods#publishedcat"

    # leaf management
    match '/mods/list',             to: "mods#list"
    match '/mods/addele',           to: "mods#addele"
    match '/mods/createele',        to: "mods#createele",         via: :post
    match '/mods/editele',          to: "mods#editele"
    match '/mods/updateele',        to: "mods#updateele",         via: :post
    match '/mods/destroyele',       to: "mods#destroyele",        via: :delete
    match '/mods/deleteallele',     to: "mods#deleteallele",      via: :post
    match '/mods/associafile',      to: "mods#associafile",       via: :post
    match '/mods/destroyimages',    to: "mods#destroyimages",     via: :post
    match '/mods/destroyallimages', to: "mods#destroyallimages",  via: :delete
    match '/mods/publishedele',     to: "mods#publishedele"
    match '/mods/updateorderele',   to: "mods#updateorderele",    via: :post

    #media management
    match '/media/destroyall',    to: "media#destroyall",   via: :post
  end

end
