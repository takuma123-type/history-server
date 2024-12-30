resources :sessions, only: [] do
  collection do
    post :sign_up
    post :log_in
  end
end

resources :infrastructures, only: [:index]

resources :scales, only: [:index]