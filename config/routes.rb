Rails.application.routes.draw do
  
  get 'admin' => 'admin#index'
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  
  resources :support_requests, only: [ :index, :update ]
  get 'sessions/create'
  get 'sessions/destroy'
  
  resources :users
  resources :products do
    get :who_bought, on: :member
    resources :reviews
  end
  
  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index', via: :all
    get 'store/questions', to: 'store#questions'
    get 'store/news', to: 'store#news'
    get 'store/contact', to: 'store#contact'
  end

  # resources :checkout, only: [ :create ]
  post "checkout/create", to: "checkout#create"
  get "checkout/create", to: "checkout#create"
  
  # delete "remove", path: "destroy/:id"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
