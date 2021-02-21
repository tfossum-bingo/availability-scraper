Rails.application.routes.draw do
  resources :availabilities
  resources :listings
  resources :hosts
  resources :updaters
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  root 'hosts#index'
  get 'welcomes', to: 'welcomes#index'

  resources :hosts do
    resources :listings
  end

  post 'updater',
       to: 'updaters#refresh_data',
       as: :refresh_scraped_data
end
