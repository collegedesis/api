Collegedesis::Application.routes.draw do
  get "comments/create"

  root to: "site#home"

  resources :sessions,            only: [:create, :destroy]
  # Used as API
  resources :organizations,       only: [:index, :show, :create, :update]
  resources :organization_types,  only: [:index, :show]
  resources :users
  resources :memberships
  resources :membership_applications, only: [:create]
  resources :membership_types,    only: [:index, :show]
  resources :universities,        only: [:index, :show]
  resources :bulletins,           only: [:index, :show, :create]
  resources :comments,            only: [:index, :create]
  # Resources

  resources :votes,               only: [:index, :create]

  # Non REST conventions
  match 'info', to: 'site#info'

  # render Ember apps
  match "/store" => redirect("/#/")
  match "/about" => redirect("/#/about")
  match "/party" => redirect("/#/radio")
  match "/radio" => redirect("/#/radio")
  match "/join" => redirect("/#/users/signup")
end
