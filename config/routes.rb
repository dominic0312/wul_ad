WooulBack::Application.routes.draw do
  resources :roles
  namespace :accounting do
    post '/account/execute_cmd',{format: :json}
    post '/account/test_inter'
  end
  devise_for :employees
	root to: 'homes#index'
	resources :homes
  resources :account_records
  resources :account_products
  resources :account_sub_invests
	resources :users
	resources :employees
end
