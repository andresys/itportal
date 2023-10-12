Rails.application.routes.draw do
  namespace :accounting do
    get '/', to: redirect { |p, r| "#{r.url}/assets" }, as: :accounting_root
    resources :assets do
      get 'print', on: :collection
      #post 'print', to: "items#print2", on: :collection
    end
  end
  resources :users

  root 'dashboard#index'
end
