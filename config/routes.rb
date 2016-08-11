Rails.application.routes.draw do
  devise_for :users
  authenticate :user do
    root to: 'home#index'

    resources :lists, only: [:new, :create, :show] do
      member do
        get 'favorite'
        get 'unfavorite'
        get 'mark_public_list'
        get 'unmark_public_list'
      end

      resources :tasks, only: [:create, :update, :show]
    end
  end
end
