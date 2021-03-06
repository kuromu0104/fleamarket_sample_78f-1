Rails.application.routes.draw do
  devise_for :users,  :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
   }
  resources :users, only: [:show, :index, :new, :create] do
    collection do
      get:logout
      get:credit_card
    end
  end

  root "items#index"

  resources :items do
    collection do
      get 'search'
      get 'category'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'buy'
      post 'pay'
      get 'done'
    end
  end

  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end

end