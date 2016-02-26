Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}

  resources :posts do
    collection do
      get 'search'
    end
    resources :questions do
      member do
        put 'open'
        put 'close'
      end
      resources :answers
    end
  end

  resources :users, only: [:index, :show]

  get 'tags/:tag', to: 'posts#tag', as: 'tag'
  get 'about', to: 'static_pages#about', as: 'about'
  get 'home', to: 'static_pages#home', as: 'home'
  root to: 'static_pages#home'
end
