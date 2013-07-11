Collegedesis::Application.routes.draw do
  get "comments/create"

  root to: "site#home"

  resources :sessions,                only: [:create, :destroy]
  # Used as API
  resources :organizations,           only: [:index, :show, :create, :update]
  resources :organization_types,      only: [:index, :show]
  resources :users
  resources :memberships,             only: [:index, :show, :destroy]
  resources :membership_applications, only: [:index, :create, :show]
  resources :membership_types,        only: [:index, :show]
  resources :universities,            only: [:index, :show]
  resources :bulletins,               only: [:index, :show, :create]
  resources :comments,                only: [:index, :create]
  resources :votes,                   only: [:index, :create]

  get '/application/:code/approve', to: 'membership_applications#approve'
  get '/application/:code/reject', to: 'membership_applications#reject'

  # Non REST conventions
  match 'info', to: 'site#info'

  # render Ember apps
  match "/news" => redirect("/#/news/1")
  match "/contact" => redirect("/#/about/contact")
  match "/store" => redirect("/#/")
  match "/about" => redirect("/#/about")
  match "/party" => redirect("/#/radio")
  match "/radio" => redirect("/#/radio")
  match "/join" => redirect("/#/users/signup")
end
