CareerLoop::Application.routes.draw do
  resources :resumes do
    member do
      get :add_video
      get :update_video
    end
  end

  resources :articles

  resources :experiences
  resources :jobs do
    collection do
      get :my
    end

    resources :job_applications do
      member do
        post :buy
        post :reject
      end
    end
  end

  resources :job_applications
  resources :payment_profiles
  resources :email_subscriptions

  resource :account do
    member do
      get :customize
    end
  end

  resources :accounts


  resources :credit_packages
  resources :credit_transactions

  devise_for :users, :controllers => {:registrations => "users/registrations", :passwords => "users/passwords"}

  root :to => 'dashboards#home'
  match ':slug' => "accounts#show", as: "slug"


end
