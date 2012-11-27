Cfp::Application.routes.draw do
  devise_for :users
  resources  :papers

  root :to => "papers#new"
end
