Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  get 'tracked_profiles', to: 'users#tracked_profiles'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stocks', to: 'stocks#search'
  get 'tracked_portfolio', to: 'users#tracked_portfolio'
  delete 'stop_tracking', to: 'users#stop_tracking'
  get 'add_friends', to: 'users#add_friends'
end


