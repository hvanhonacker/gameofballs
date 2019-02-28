Rails.application.routes.draw do
  resources :games do
    resources :game_events, only: :create
  end

  root to: "games#index"
end
