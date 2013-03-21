CareerLoop::Application.routes.draw do
  resources :profiles
  resources :articles

  resources :experiences
  resources :jobs do
    collection do
      get :my
    end

    resources :job_applications do
      member do
        post :buy
      end
    end
  end


  resources :accounts

  resources :credit_packages
  resources :credit_transactions

  devise_for :users, :controllers => {:registrations => "users/registrations", :passwords => "users/passwords"}

  root :to => 'dashboards#home'
  match ':slug' => "pages#show", as: "page_slug"


end
