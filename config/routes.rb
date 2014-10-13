WooulBack::Application.routes.draw do
  resources :roles
  namespace :accounting do
    post '/account/execute_cmd',{format: :json}
  end
  devise_for :employees
	root to: 'homes#index'
	resources :homes
  resources :account_records
	resources :users
	resources :employees
end
