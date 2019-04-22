Rails.application.routes.draw do
  # www redirect
  match '(*any)', to: redirect(subdomain: ''), via: :all, constraints: {subdomain: 'www'}

  get 'lifetime', to: 'lifetime#index'
  resources :players, only: [:show]
  resources :teams, only: [:show]

  root to: "overview#index"
end
