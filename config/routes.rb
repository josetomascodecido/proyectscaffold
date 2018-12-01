Rails.application.routes.draw do


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'geocoder/findaddress'
  devise_for :users, controllers: {
              registrations: 'users/registrations',
              :omniauth_callbacks => "users/omniauth_callbacks"
  }
  resources :stores do
    resources :products
    resources :orders do
              collection do
                patch 'confirm_orders'
              delete 'empty_cart'
            end
          end
      # buscar rutas custom to: as:

  end

  root to: 'stores#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
