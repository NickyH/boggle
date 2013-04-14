Words::Application.routes.draw do
  root :to => 'home#index'

  resources :users, :games

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/start' => 'games#start'
  post '/add_word' => 'games#add_word'
  get '/game/:game_name/new_game' => 'games#new_game'
  get '/new_game_form' => 'games#new_game_form'
end
