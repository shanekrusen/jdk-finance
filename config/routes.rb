Rails.application.routes.draw do
  get 'sessions/login'

  post 'sessions/login_attempt'

  get 'sessions/home'

  get 'sessions/profile'

  get 'sessions/setting'

  get 'users/new'

  get 'reports/weeks'

  root :to => "incomes#index"

  resources :categories
  resources :incomes
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
