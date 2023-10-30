Rails.application.routes.draw do
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only: [:index, :show]
    resource :customers, only: [:show] do
      get 'information/edit' => 'customers#edit'
      patch 'information' => 'customers#update'
      get 'check'
      patch 'leave'
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :orders, only: [:new, :index, :show, :create] do
      collection do
        get 'confirm'
        get 'complete'
      end
    end
    resources :addresses, except: [:show, :new]
  end

  namespace :admin do
    get '/' => 'homes#top'
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update] do
      member do
        get 'order'
      end
    end
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
