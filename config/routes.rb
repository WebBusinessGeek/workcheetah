CareerLoop::Application.routes.draw do

  get '/businesses',     to: 'staticpages#staticbusinesses'
  get '/freelancers',    to: 'staticpages#staticfreelancers'
  get '/employees',      to: 'staticpages#staticemployees'
  get '/pagetwo',        to: 'staticpages#staticpagetwo'
  get '/pageone',        to: 'staticpages#staticpageone'
  get '/pagethree',      to: 'staticpages#staticpagethree'

  resources :payments

  resources :shifts do
    member do
      post :clock_in
      post :clock_out
    end
    collection do
     post :invite
     get :calendar
     get :client_calendar
     get :client_calendar_ajax
   end
  end

  resources :todos, only: [:index, :new, :create, :destroy] do
    collection { post :sort }
    member { post :complete }
  end

  resources :invoices, only: [:create, :new, :update, :destroy] do
    member do
      post :invite
      post :pay
    end
  end
  get 'staffing' => 'shifts#index', as: :staffing
  get 'accounting' => 'invoices#index', as: :accounting
  get "invoices/:guid" => "invoices#show"
  get "invoices/:guid/edit" => "invoices#edit", as: :edit_invoice

  resources :staffs do
    member do
      post :remove
    end
  end
  get 'contacts' => 'staffs#contacts', as: :contacts

  resources :activities, only: [:index]
  resources :projects do
    resources :timesheets
    resources :invoices, only: [:new]
    resources :project_documents
    resources :comments
    member { post :invite }
    resources :tasks do
      member { post :complete}
    end
    collection { post :sort }
  end

  post 'tasks/sort' => "tasks#sort", as: :sort_tasks

  resources :events do
    collection do
      get :ajax_events
    end
  end

  resources :estimates do
    resources :comments
    collection do
      get :for_job
      get :recieved
    end
    member do
      post :buy_credits
      post :propose
      post :accept
      post :reject
      post :negotiate
    end
  end

  resources :blog_categories

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
  get '/fetch_ads_group' => 'dashboards#fetch_ads_group', as: :next_ads_group
  post "/how-ads-work" => "advertisers/dashboard#create_sign_up", as: :create_advertiser_sign_up

  namespace :advertisers do
    root to: "dashboard#home", via: :get, as: :advertisers
    resources :payment_profiles, only: [:new, :create, :destroy]
    resources :accounts, except: [:destroy]
    resources :invoices, only: [:index]
    get '/invoice/:guid', to: 'invoices#show', as: :invoice
    resources :campaigns do
      member do
        post :toggle
      end
    end
    resources :advertisements do
      member do
        post :toggle
        get :click_through
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
      get :draft
      get :sent
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
      get :index, as: :search
    end
  end
  resources :validation_requests, only: [:new, :create]
  resources :scam_reports, only: [:new, :create]

  resources :resumes, except: [:index] do
    resources :references, only: [:new, :create, :edit, :update]
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
      post :buy_invites
    end

    member do
      post :flag
      get :claim
      post :invite_job_seekers, as: :invite_job_seekers_to
    end

    resources :job_applications do
      member do
        post :hire
        post :reject
        post :apply_with_questionaire
      end
    end
  end

  resources :job_applications
  resources :payment_profiles
  resources :email_subscriptions

  resources :accounts do
    member do
      post :suspend
      get :recruits
      get :customize
      get :add_seal
      get :remove_seal
      post :buy_seal
    end
  end
  resources :notifications, only: [:index, :destroy]
  resources :credit_packages
  resources :credit_transactions

  devise_for :users, :controllers => { :registrations => "users/registrations" }

  resource :user

  post "/moderators" => "users#create_moderator", as: :create_moderator
  delete "/moderators/:id" => "users#destroy_moderator", as: :destroy_moderator
  post "/users/update_bank_account" => "users#update_bank_account", as: :update_bank_account

  get "/image_ad" => "advertisers/advertisements#image_ad"
  get "/text_ad" => "advertisers/advertisements#text_ad"
  root :to => 'dashboards#home'
  match '/contact' => "pages#contact", as: "contact"
  match '/admin' => "dashboards#admin", as: "admin"
  match '/moderator' => "dashboards#moderator", as: "moderator"
  # match ':slug' => "accounts#show", as: "slug"
  match '/errors/error_404' => "errors#error_404"
  match '/errors/error_500' => "errors#error_500"

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
end
