Cfp::Application.routes.draw do
  get "home/show"

  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => {
    :registrations => 'registrations',
    :sessions => 'sessions',
    :passwords => 'passwords'
  }

  resource   :profile
  resources  :papers, only: [:index, :show]
  resources  :authentications

  namespace :admin do
    resources :papers
    resources :users
    root :to => "papers#index"
  end
  root :to => "home#show"
end
