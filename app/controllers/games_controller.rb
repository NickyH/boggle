class GamesController < ApplicationController
  def index
    redirect_to root_path if @auth.nil?
  end
  def create
    name = (params[:name]).downcase
    game = Game.where(:name => name, :is_active => true).first_or_create
    @auth.games.each {|game| game.is_active = false}
    game.is_active = true
    @auth.games << game
    redirect_to "/games/#{game.name}"
  end
  def start
    letters = [['R', 'I', 'F', 'O', 'B', 'X'], ['I', 'F', 'E', 'H', 'E', 'Y'], ['D', 'E', 'N', 'O', 'W', 'S'], ['U', 'T', 'O', 'K', 'N', 'D'], ['H', 'M', 'S', 'R', 'A', 'O'], ['L', 'U', 'P', 'E', 'T', 'S'], ['A', 'C', 'I', 'T', 'O', 'A'], ['Y', 'L', 'G', 'K', 'U', 'E'], ['Q', 'B', 'M', 'J', 'O', 'A'], ['E', 'H', 'I', 'S', 'P', 'N'], ['V', 'E', 'T', 'I', 'G', 'N'], ['B', 'A', 'L', 'I', 'Y', 'T'], ['E', 'Z', 'A', 'V', 'N', 'D'], ['R', 'A', 'L', 'E', 'S', 'C'], ['U', 'W', 'I', 'L', 'R', 'G'], ['P', 'A', 'C', 'E', 'M', 'D']]
    @letters = (letters.map{ |d| d.shuffle.first }).shuffle
    @auth.current_game.letters = @letters.join
    @auth.current_game.update_attributes(:letters => @letters.join)
  end
  def answers

  end
  def add_word
    score = 0
    answer = Answer.create(word: params[:words])
    a = answer.word.split('')
    l = @auth.current_game.letters.split('')
    valid = true
    a.each do |letter|
      if l.include?(letter.upcase) && valid = true
        valid = true
        answer.is_valid = true
      else
        valid = false
        answer.is_valid = false
      end
    end
    if answer.is_valid == true && answer.word.length > 2
      game = @auth.current_game
      all_words = game.users.map(&:answers).flatten.map(&:word)
      match_words = all_words.where(:word => answer.word)
      match_words.each do |match|
        match.is_taken = true
      end
      Pusher.trigger(game.name, 'refresh_words', '')
    else
      if answer.word.length > 2 && answer.is_valid == true
        @auth.current_game.answers << answer
        score = @auth.current_game.score + answer.word.length - 2
        @answers = @auth.current_game.answers
        @auth.current_game.update_attributes(score: score) if score != 0
      end
    end
  end
  def refresh_words
    @auth.current_game.answers << answer
    score = @auth.current_game.score + answer.word.length - 2
    @auth.current_game.update_attributes(score: score) if score != 0
    @answers = @auth.current_game.answers.where(:username => @auth.username)
    @score = @auth.current_game.score.where(:username => @auth.username)
  end
  end
  def new_game_form
  end
  def show
    redirect_to root_path if @auth.nil?
    game = Game.where(:name => params[:name]).first
    Pusher.trigger(game.name, 'select_channel', @auth.username)
  end
  def invite

  end
  def sendtxt
    name = params[:name]
    body = "Hi #{name}, you've been invited by #{@auth.username} to join in a game of Boggle. Just login and join the game #{@auth.current_game.name}"
    phone = params[:phone]
    client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
    client.account.sms.messages.create(:from => '+16468635581', :to => phone, :body => body)
  end
  def end_game

  end
end