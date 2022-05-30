Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api, format: 'json' do
    resources :apexdatas, only: [:index, :create, :destroy, :show]
  end
end
