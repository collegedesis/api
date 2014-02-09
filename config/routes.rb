Collegedesis::Application.routes.draw do
  resources :api_keys, except: [:new, :edit]
  root to: 'site#home'

  resources :organizations,           only: [:index, :show, :create, :update] do
    collection { get :search }
  end
  resources :organization_types,      only: [:index, :show]
  resources :users
  resources :memberships,             only: [:index, :show, :destroy]
  resources :membership_applications, only: [:index, :create, :show]
  resources :membership_types,        only: [:index, :show]
  resources :universities,            only: [:index, :show]
  resources :bulletins,               only: [:index, :show, :create]
  resources :comments,                only: [:index, :create]
  resources :views,                   only: [:create]
  resources :sessions,                only: [:create, :destroy]

  # TODO do this better
  get 'info', to: 'stats#info'

  # Legacy. TODO needs update
  get '/application/:code/approve', to: 'membership_applications#approve'
  get '/application/:code/reject', to: 'membership_applications#reject'

  match '/*path' => 'application#cors_preflight_check', via: :options
end
