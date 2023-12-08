require 'sidekiq/web'

class AdminConstraint
  def matches?(request)
    true
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => 'sidekiq', constraints: AdminConstraint.new

  concern :noteble do
    resources :notes, except: %i[new edit]
  end

  resources :jobs, only: %i[index show]
  resources :images, only: %i[destroy]

  namespace :directories do
    get '/', to: redirect { |p, r| "#{r.url}/organizations" }, as: :root

    resources :organizations, only: %i[index] do
      resource :staffing, on: :collection, only: %i[create show]
      resources :departments, only: %i[new create show update destroy]
      resources :titles, only: %i[new create show update destroy]
    end
    resources :locations, only: %i[index new create show update destroy]
    resources :employees, only: %i[index new create edit import] do
      get 'import', on: :collection
    end
    resources :mols, only: %i[index]
    resources :staffing_tables, only: %i[index new create edit]
    # resources :departments, only: %i[index]
    # resources :titles, only: %i[index]
  end

  namespace :accounting do
    get '/', to: redirect { |p, r| "#{r.url}/assets" }, as: :root

    resources :assets, only: %i[index show edit update], concerns: :noteble
    resources :materials, only: %i[index show edit update], concerns: :noteble
    resources :notes, only: %i[index show destroy]
    resources :prints, only: %i[index]
  end
  resources :users

  if Rails.env == "production"
    get '/', to: redirect { |p, r| "#{r.url}/accounting" }, as: :root
  else
    root 'dashboard#index'
  end
  
end
