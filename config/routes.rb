Cfp::Application.routes.draw do
  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => {
    :registrations => 'registrations',
    :sessions => 'sessions',
    :passwords => 'passwords'
  }

  resource   :profile
  resources  :papers
  resources  :authentications

  root :to => "papers#new"
end
