CareerLoop::Application.routes.draw do

  resources :confirmations, only: [:new, :create] do
    member do
      get :reference, as: :reference_confirm
    end
  end
  get "/confirmation" => "confirmations#show", as: :reference_confirmation

  resources :comments, only: [ :create ]

  get "/how-ads-work" => "dashboards#ad_info", as: :ad_info
  get "/how-jobs-work" => "dashboards#job_info", as: :job_info
  get "how-resumes-work" => "dashboards#resume_info", as: :resume_info
  post "/how-ads-work" => "advertisers/dashboard#create_sign_up", as: :create_advertiser_sign_up

  namespace :advertisers do
    root to: "dashboard#home", via: :get, as: :advertisers
    resources :accounts, except: [:destroy]
    resources :campaigns do
      member do
        post :toggle
      end
    end
    resources :advertisements do
      member do
        post :toggle
      end
    end
  end

  resources :blocks, only: [ :create ] do
    collection do
      delete :destroy
    end
  end

  resources :conversations, only: [ :index, :show, :create, :update, :new ] do
    collection do
      post :send_to_all
    end
  end

  resources :tweets
  resources :video_chat_messages, only: [ :create ]

  resources :video_chats do
    member do
      put :accept
    end
  end

  resources :categories, only: [:index, :show, :create, :new, :edit, :update] do
    collection do
      get :index_new, as: :search
    end
  end
  resources :validation_requests, only: [:new, :create]
  resources :scam_reports, only: [:new, :create]

  resources :resumes do
    member do
      get :add_video
      get :update_video
      get :claim
    end
    collection do
      get :search
    end
  end

  resources :articles
  resources :experiences

  resources :jobs do
    collection do
      get :my
      post :quick_apply, as: :quick_apply_to
    end

    member do
      post :flag
      get :claim
      post :invite_job_seekers, as: :invite_job_seekers_to
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

  post "/moderators" => "users#create_moderator", as: :create_moderator
  delete "/moderators/:id" => "users#destroy_moderator", as: :destroy_moderator

  root :to => 'dashboards#home'
  match '/contact' => "pages#contact", as: "contact"
  match '/admin' => "dashboards#admin", as: "admin"
  match '/moderator' => "dashboards#moderator", as: "moderator"
  match ':slug' => "accounts#show", as: "slug"
  match '/errors/error_404' => "errors#error_404"
  match '/errors/error_500' => "errors#error_500"

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
end
