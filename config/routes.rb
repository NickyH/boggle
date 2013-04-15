Words::Application.routes.draw do
  root :to => 'home#index'

  resources :users

  resources :games, only: [:index, :create]
  get '/games/:name' => 'games#show'
  get '/games/:name/end_game' => 'games#end_game'


  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/start' => 'games#start'
  post '/add_word' => 'games#add_word'
  get '/invite' => 'games#invite'
  post '/sendtxt' => 'games#sendtxt'
  get '/new_game_form' => 'games#new_game_form'
end
