Cfp::Application.routes.draw do
  get "home/show"

  get '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => {
    :registrations => 'registrations',
    :sessions => 'sessions',
    :passwords => 'passwords'
  }

  resource   :profile
  resources  :calls do
    resources :papers, only: [:new, :create]
  end
  resources  :papers,  only: [:index, :show, :edit, :update, :destroy]
  resources  :authentications

  namespace :admin do
    resources :papers
    resources :users
    root :to => "papers#index"
  end
  root :to => "home#show"
end
