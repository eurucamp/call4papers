Cfp::Application.routes.draw do
  get "home/show"
  get "guide", :to => "pages#guide"
  get "mentorship", :to => "pages#mentorship"

  get '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => {
    :registrations => 'registrations',
    :sessions => 'sessions',
    :passwords => 'passwords'
  }

  resource   :profile
  resources  :calls do
    resources :proposed_speakers, only: [:new, :create]
  end
  resources  :talks
  resources  :proposed_speakers, only: [:destroy, :index]
  resources  :authentications

  namespace :admin do
    resources :proposed_speakers, only: [:index] do
      collection do
        get :export
      end
    end
    resources :proposals, only: [:update, :show] do
      collection do
        get :export
      end
      member do
        post :note, :to => "notes#create"
        patch :note, :to => "notes#update"

        resource :user_proposal_rating, only: [:create, :update]
      end
    end
    resources :calls, only: :index do
      resources :proposals
    end
    resources :users do
      collection do
        get :export
      end
    end
    resources :communications do
      member do
        post :deliver
      end
    end
    root :to => "calls#index", as: :root
  end

  namespace :mentor do
    resources :talks, only: [:index]

    post "feedbacks/:id", :to => "feedbacks#contact", as: :feedback

    root :to => "proposals#index", as: :root
  end
  root :to => "home#show"
end
