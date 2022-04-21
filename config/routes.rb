Rails.application.routes.draw do

  if Rails.env.staging?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  scope :app do
    devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
    resources :rides, except: [:index]
    get "dashboard", to: "dashboard#index"
    get "pending_rides", to: "pending_rides#index"
    get "terms_and_conditions", to: "terms_and_conditions#index"
    get "admin_dashboard", to: "admin_dashboard#index"
    get "unverified_drivers", to: "unverified_drivers#index"
    resources :users, only: [:show, :edit, :update] do
      resources :vehicles
    end

    resources :signup_processes

    match '*a', to: 'application#app_not_found', via: :get
  end

  get '/404', to: 'errors#not_found', via: :all
  get '/500', to: 'errors#internal_server', via: :all
  get '/422', to: 'errors#unprocessable', via: :all
end
