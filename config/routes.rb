require 'sidekiq/web'

class AdminConstraint
  def matches?(request)
    true
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => 'sidekiq', constraints: AdminConstraint.new


  resources :jobs, only: %i[index show]

  resources :images, only: %i[destroy]

  namespace :accounting do
    get '/', to: redirect { |p, r| "#{r.url}/assets" }, as: :accounting_root

    resources :assets, only: %i[index import show update destroy] do
      get 'import', on: :collection
      get 'print', on: :collection
      #post 'print', to: "items#print2", on: :collection
      # resources :images, only: [:show, :destroy], :defaults => { :format => :json }, constraints: lambda { |req| ['json'].include?(req.format) }
      resources :notes, only: %i[create]
    end
    resources :materials, only: %i[index import show update destroy] do
      get 'import', on: :collection
      resources :notes, only: %i[create]
    end
    resources :mols, only: %i[index]
  end
  resources :users

  root 'dashboard#index'
end
