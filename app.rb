require('sinatra')
require('sinatra/reloader')
require('./lib/game')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  erb(:home)
end

get('/play') do
  @game = Game.new
  @game.save
  @mystery_word = @game.get_blanks
  erb(:play)
end

patch('/play') do
  letter = params[:letter].downcase
  @game = Game.find
  @game.guess(letter)
  @wrong_guesses = @game.guesses.join(", ")
  @mystery_word = @game.fill_in(letter)
  erb(:play)
end