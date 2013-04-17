class GamesController < ApplicationController
  def index
    redirect_to root_path if @auth.nil?
  end
  def create
    name = (params[:name]).downcase
    name = name.gsub(" ", "").squish
    games = Game.where(:name => name, :is_active => true)

    games.each do |game|
      game.is_active = false
      game.save
    end

    game = Game.create(name: name, is_active: true)

    game.users << @auth

    redirect_to("/games/#{game.name}")
  end
  def start
    game = Game.where(name: params[:name]).first
    letters = [['R', 'I', 'F', 'O', 'B', 'X'], ['I', 'F', 'E', 'H', 'E', 'Y'], ['D', 'E', 'N', 'O', 'W', 'S'], ['U', 'T', 'O', 'K', 'N', 'D'], ['H', 'M', 'S', 'R', 'A', 'O'], ['L', 'U', 'P', 'E', 'T', 'S'], ['A', 'C', 'I', 'T', 'O', 'A'], ['Y', 'L', 'G', 'K', 'U', 'E'], ['Q', 'B', 'M', 'J', 'O', 'A'], ['E', 'H', 'I', 'S', 'P', 'N'], ['V', 'E', 'T', 'I', 'G', 'N'], ['B', 'A', 'L', 'I', 'Y', 'T'], ['E', 'Z', 'A', 'V', 'N', 'D'], ['R', 'A', 'L', 'E', 'S', 'C'], ['U', 'W', 'I', 'L', 'R', 'G'], ['P', 'A', 'C', 'E', 'M', 'D']]
    @letters = (letters.map{ |d| d.shuffle.first }).shuffle

    game.letters = @letters.join
    game.save

    Pusher.trigger(game.name, 'start_game', game.name)
  end
  def start_game
    game = Game.where(name: params[:name]).first
    @letters = game.letters
  end
  def answers

  end
  def add_word
    game = Game.where(:name => params[:name]).first
    answer = Answer.create(word: params[:words].upcase, is_valid: true)

    word = answer.word.to_s.downcase
    answer.is_valid = false if answer.word.length < 3
    answer.save
    if answer.is_valid == true
      answer.is_valid = Wordnik.word.get_definitions(word).any?
      answer.save
    end

    # start dup search across all players words
    myletters = answer.word.split('')
    letters = game.letters.split('')

    myletters.each {|l| answer.is_valid = false if letters.exclude?(l)}
    result = Result.where(game_id: game.id, user_id: @auth.id).first

    results = Result.where(game_id: game.id)
    is_dup = results.map(&:answers).flatten.map(&:word).include?(answer.word)

    if is_dup
      answer.is_taken = true
      duplicates = results.map(&:answers).flatten.select{|a| a.word == answer.word}
      duplicates.each do |dup|
        dup.is_taken = true
        dup.result.score -= 1
        dup.save
      end
    end

    # getting scores for words greater than 2
    if answer.word.length > 4 && answer.is_valid == true
      result.score = result.score + answer.word.length + 2
    elsif answer.word.length < 5 && answer.is_valid == true
      result.score = result.score + 1
      result.save
    end

    # checking for best_word
    game.best_word = answer.word if answer.word.length > game.best_word.length
    game.save

    result.answers << answer

    Pusher.trigger(game.name, 'refresh_words', game.name)
    render :nothing => true
end
def refresh_words
  game = Game.where(:name => params[:name]).first
  @result = Result.where(game_id: game.id, user_id: @auth.id).first
end
def new_game_form
end
def show
  redirect_to root_path if @auth.nil?
  @game = Game.where(:name => params[:name]).first
  @game.users << @auth if @game.users.exclude?(@auth)
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
