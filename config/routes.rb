Words::Application.routes.draw do
  root :to => 'home#index'

  resources :users

  resources :games, only: [:index, :create, :destroy]
  get '/games/:name' => 'games#show'
  get '/end_game' => 'games#end_game'
  get '/games/refresh_words/:name' => 'games#refresh_words'
  get '/rules' => 'home#rules'


  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/start/:name' => 'games#start'
  post '/games/add_word' => 'games#add_word'
  get '/invite/:name' => 'games#invite'
  post '/sendtxt' => 'games#sendtxt'
  get '/new_game_form' => 'games#new_game_form'
  get'/games/start_game/:name' => 'games#start_game'
  get '/games/refresh_selection/refresh/:game' => 'games#refresh_selection'
end
