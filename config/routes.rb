CareerLoop::Application.routes.draw do
  resources :categories
  resources :validation_requests, only: [:new, :create]
  resources :scam_reports, only: [:new, :create]

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

    member do
      post :flag
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
      get :add_seal
      get :remove_seal
      post :buy_seal
    end
  end

  resources :accounts do
    member do
      post :suspend
      get :recruits
    end
  end


  resources :credit_packages
  resources :credit_transactions

  devise_for :users, :controllers => { :registrations => "users/registrations" }

  resource :user
  #  do
  #   member do
  #     get :change_password
  #     put :update_password
  #   end
  # end

  root :to => 'dashboards#home'
  match '/admin' => "dashboards#admin", as: "admin"
  match ':slug' => "accounts#show", as: "slug"
  match '/errors/error_404' => "errors#error_404"
  match '/errors/error_500' => "errors#error_500"

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
end
