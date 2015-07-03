require 'api_constraints'


Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # Api definition
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1, default: true) do
          resources :users, :only => [:show, :create, :update, :destroy] do
            resources :tasks, :only => [:create, :update, :destroy]
          end
          resources :sessions, :only => [:create, :destroy]
          resources :tasks, :only => [:show, :index]
    end
  end

end
