Collegedesis::Application.routes.draw do
  get "comments/create"

  root to: "site#home"

  resources :sessions,            only: [:create, :destroy]
  # Used as API
  resources :organizations,       only: [:index, :show, :create, :update]
  resources :organization_types,  only: [:index, :show]
  resources :messages,            only: [:create]
  resources :events,              only: [:index, :create]
  resources :users
  resources :memberships
  resources :universities,        only: [:index, :show]
  resources :bulletins,           only: [:index, :show, :create]
  resources :comments,            only: [:index, :create]
  # Resources
  resources :products,            only: [:index, :show]
  resources :purchases,           only: [:create, :show]
  resources :votes,               only: [:index]
  # Non REST conventions
  match '/verifications/verify', to: 'verifications#verify'
  match 'info', to: 'site#info'
  resources :messages do
    collection do
      post 'tests'
    end
  end

  # render Ember apps
  match "/store" => redirect("/#/store")
  match "/reps" => redirect("/#/reps")
  match "/party" => redirect("/#/radio")
  match "/radio" => redirect("/#/radio")
  match "/press" => redirect("/#/")
  match "/organizations/:id/apply", to: 'organizations#apply'
  # not being used currently
  resources :letters
  resources :stories
  resources :votes, only: [:create]
end
