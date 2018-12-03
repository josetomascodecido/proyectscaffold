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
                patch 'payed_orders'
                get 'historial'
              delete 'empty_cart'
            end
            member do
              patch 'confirm_order'
              patch 'delivered_order'
            end
          end
      # buscar rutas custom to: as:

  end

  root to: 'stores#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
