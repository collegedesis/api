Collegedesis::Application.routes.draw do
  root to: "site#home"
  
  # Used as API
  resources :organizations,       only: [:index, :show, :create, :update]
  resources :organization_types,  only: [:index, :show]
  resources :messages,            only: [:create]
  resources :events,              only: [:index, :create]
  resources :users
  resources :memberships
  resources :universities,        only: [:index, :show]
  resources :bulletins,           only: [:index, :show, :create]
  
  # Resources
  resources :products,            only: [:index, :show]
  resources :purchases,           only: [:create, :show]
    
  # Non REST conventions
  match '/verifications/verify', to: 'verifications#verify'
  
  resources :messages do 
    collection do 
      post 'tests' 
    end 
  end

  # render Ember apps
  match '/press', to: 'ember_apps#blog'
  match '/store', to: 'products#index'

  # not being used currently
  resources :letters
  resources :stories
  resources :votes, only: [:create]
end
