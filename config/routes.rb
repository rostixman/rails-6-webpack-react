Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      # users
      get  'users', to: 'users#list'
      get  'users/:id', to: 'users#show'
      post    'users', to: 'users#create'
      delete  'users', to: 'users#destroy'

      # sessions
      post    'sessions', to: 'sessions#create'
      delete  'sessions', to: 'sessions#destroy'
    end
  end

  namespace :site, path: '' do
    root to: 'main#index'
    get '/*path', to: 'main#index'
  end
end
