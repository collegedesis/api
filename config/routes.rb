Collegedesis::Application.routes.draw do
  root to: 'site#home'

  # Sessions
  resources :sessions,                only: [:create, :destroy]

  namespace :api do
    namespace :v1 do
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
      # TODO do this better
      match 'info', to: 'stats#info'

      # Legacy. TODO needs update
      get '/application/:code/approve', to: 'membership_applications#approve'
      get '/application/:code/reject', to: 'membership_applications#reject'
    end
  end

  # Used to render inside the `noscript` tags for SEO
  resources :d, only: [:show]
  resources :n, only: [:show]

  # Catch all to serve ember app
  get '*foo', to: 'site#home'
end
