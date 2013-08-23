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
    end
  end

  # Legacy. TODO needs update
  get '/application/:code/approve', to: 'membership_applications#approve'
  get '/application/:code/reject', to: 'membership_applications#reject'

  # Smart URLs
  # TODO handle this client side
  get '/join', to: redirect('/users/join')
  get '/me', to: redirect('/users/me')

  # Catch all to serve ember app
  get '*foo', to: 'site#home'
end
