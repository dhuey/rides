Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  if Rails.env.staging?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :rides
  get "pending_rides", to: "pending_rides#index"
  resources :users, only: [:show, :edit, :update] do
    resources :vehicles
  end
end
