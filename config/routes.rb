require 'sidekiq/web'

class AdminConstraint
  def matches?(request)
    true
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => 'sidekiq', constraints: AdminConstraint.new


  resources :jobs, only: %i[index show]

  namespace :accounting do
    get '/', to: redirect { |p, r| "#{r.url}/assets" }, as: :accounting_root

    resources :assets do
      get 'import', on: :collection
      get 'print', on: :collection
      #post 'print', to: "items#print2", on: :collection
      # resources :images, only: [:show, :destroy], :defaults => { :format => :json }, constraints: lambda { |req| ['json'].include?(req.format) }
      member do
        delete :delete_image_attachment
      end
    end
    resources :materials, only: %i[index import show] do
      get 'import', on: :collection
    end
    resources :mols, only: %i[index]
  end
  resources :users

  root 'dashboard#index'
end
