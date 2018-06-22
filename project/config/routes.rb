Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root controller: :pages, action: :root
  namespace :api, defaults: {format: :json} do
    namespace :public do
      resources :locations, param: :country_code, only: :show
      resources :target_groups, param: :country_code, only: :show
    end
    namespace :private do
      resources :locations, param: :country_code, only: :show
      resources :target_groups, param: :country_code, only: :show
      post :evaluate_target, to: "pricings#evaluate_target"
    end
  end
end
