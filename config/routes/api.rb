resources :sessions, only: [] do
  collection do
    post :sign_up
  end
end