Cfp::Application.routes.draw do
  get "home/show"

  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => {
    :registrations => 'registrations',
    :sessions => 'sessions',
    :passwords => 'passwords'
  }

  resource   :profile
  resources  :papers
  resources  :authentications

  root :to => "home#show"
end
