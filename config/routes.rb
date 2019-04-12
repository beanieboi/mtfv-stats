Rails.application.routes.draw do
  get 'lifetime', to: 'lifetime#index'
  root to: "overview#index"
end
