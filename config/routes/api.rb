resources :sessions, only: [] do
  collection do
    post :sign_up
    post :log_in
  end
end
resources :infrastructures, only: [:index]
resources :scales, only: [:index]
resources :positions, only: [:index]
resources :core_stacks, only: [:index]
resources :histories, only: [:index, :create, :show] do
  member do
    get :export
  end
end