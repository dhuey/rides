Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  if Rails.env.staging?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :rides
  get "pending_rides", to: "pending_rides#index"
  get "terms_and_conditions", to: "terms_and_conditions#index"
  get "admin_dashboard", to: "admin_dashboard#index"
  get "unverified_drivers", to: "unverified_drivers#index"
  resources :users, only: [:show, :edit, :update] do
    resources :vehicles
  end

  resources :signup_processes
end
