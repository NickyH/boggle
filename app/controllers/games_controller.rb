class GamesController < ApplicationController
  def index
  end
  def create
    name = params[:name]
    game = Game.where(:name => name, :is_active => true).first_or_create
    @auth.games << game
    Pusher.trigger(game.name, 'select_channel', @auth.games.last.name)
    redirect_to "/game/#{game.name}/new_game"
  end
  def start
    letters = [['R', 'I', 'F', 'O', 'B', 'X'], ['I', 'F', 'E', 'H', 'E', 'Y'], ['D', 'E', 'N', 'O', 'W', 'S'], ['U', 'T', 'O', 'K', 'N', 'D'], ['H', 'M', 'S', 'R', 'A', 'O'], ['L', 'U', 'P', 'E', 'T', 'S'], ['A', 'C', 'I', 'T', 'O', 'A'], ['Y', 'L', 'G', 'K', 'U', 'E'], ['Qu', 'B', 'M', 'J', 'O', 'A'], ['E', 'H', 'I', 'S', 'P', 'N'], ['V', 'E', 'T', 'I', 'G', 'N'], ['B', 'A', 'L', 'I', 'Y', 'T'], ['E', 'Z', 'A', 'V', 'N', 'D'], ['R', 'A', 'L', 'E', 'S', 'C'], ['U', 'W', 'I', 'L', 'R', 'G'], ['P', 'A', 'C', 'E', 'M', 'D']]
    @letters = (letters.map{ |d| d.shuffle.first }).shuffle
  end
  def answers

  end
  def add_word
    answer = Answer.create(word: params[:words])
    @auth.current_game.answers << answer
    @answers = @auth.current_game.answers
    # check here if word is valid
  end
  def new_game_form
  end
  def new_game

  end
end