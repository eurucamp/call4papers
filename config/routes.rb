Cfp::Application.routes.draw do
  devise_for :users
  resources  :papers
  resource   :profile

  root :to => "papers#new"
end
