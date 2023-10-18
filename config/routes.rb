Rails.application.routes.draw do
  namespace :accounting do
    get '/', to: redirect { |p, r| "#{r.url}/assets" }, as: :accounting_root
    resources :assets do
      get 'print', on: :collection
      #post 'print', to: "items#print2", on: :collection
      # resources :images, only: [:show, :destroy], :defaults => { :format => :json }, constraints: lambda { |req| ['json'].include?(req.format) }
      member do
        delete :delete_image_attachment, :defaults => { :format => :json }, constraints: lambda { |req| ['json'].include?(req.format) }
      end
    end
  end
  resources :users

  root 'dashboard#index'
end
