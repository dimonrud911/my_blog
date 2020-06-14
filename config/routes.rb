Rails.application.routes.draw do
  namespace :api do
    resources :categories do
      resources :posts
    end
    resources :users, only: [:index, :show]
  end

  devise_for :users, defaults: { format: :json },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'api/categories#index'
end
