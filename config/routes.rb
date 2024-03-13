require 'sidekiq/web'

class SuperAdminConstraint
  def matches?(request)
    user_id = request.session["warden.user.user.key"][0][0]
    User.find_by(id: user_id)&.has_role?(:superadmin)
  end
end

Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join('|')}/ do
    concern :noteble do
      resources :notes, except: %i[new edit]
    end

    concern :possessionable do
      resources :possessions, except: %i[edit]
    end

    resources :images, only: %i[destroy]

    namespace :accounting do
      resources :assets, only: %i[index show edit update destroy], concerns: %i[noteble possessionable]
      resources :materials, only: %i[index show edit update destroy], concerns: %i[noteble possessionable]
      resources :notes, only: %i[index edit destroy], path_names: {edit: ''}
      resources :prints, only: %i[index]
    end

    namespace :directories do
      resources :organizations, except: %i[show], path_names: {edit: ''} do
        resource :staffing, on: :collection, only: %i[create show destroy]
        resources :departments, except: %i[show], path_names: {edit: ''}
        resources :titles, except: %i[show], path_names: {edit: ''}
      end
      resources :employees, except: %i[show], path_names: {edit: ''}
      resources :mols, only: %i[index]
      resources :locations, except: %i[show], path_names: {edit: ''} do
        resources :rooms, except: %i[index show], path_names: {edit: ''}
      end
      resources :asset_types, except: %i[show], path_names: {edit: ''}
    end

    devise_for :users, path: "", path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      password: 'forgot',
      edit: 'profile/password',
      sign_up: 'registration'
    }

    resources :users, except: %i[edit] do
      resources :roles, except: %i[show], module: :users, path_names: {new: 'add'}
      resource :emails, only: %i[edit update], module: :users, path_names: {edit: ''}, path: 'email'
      resource :passwords, only: %i[edit update], module: :users, path_names: {edit: ''}, path: 'password'
      resource :approveds, only: %i[create destroy], module: :users, path: 'approved'
    end

    resources :jobs, only: %i[index new create show destroy]

    mount Sidekiq::Web => 'sidekiq', constraints: SuperAdminConstraint.new, as: :sidekiq

    resource :profile, only: %i[show update] do
      resource :preferences, only: %i[edit update], path_names: {edit: ''}
      resource :emails, only: %i[edit update], module: :profile, path_names: {edit: ''}, path: 'email'
    end

    resource :settings, only: %i[show] do
      patch 'general', on: :collection
      patch 'notification', on: :collection
    end
    
    if Rails.env == "production"
      get '/', to: redirect { |p, r| "#{r.url.sub(/(\/)+$/,'')}/profile" }, as: :root
    else
      root 'dashboard#index'
    end

    get 'directories', to: "directories#redirect", as: :directories_root
    get 'accounting', to: "accounting#redirect", as: :accounting_root
    get ":page", to: "static_pages#show"
  end
end
