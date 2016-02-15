require 'yaml'

#hangman class that will hold the methods
class Player
	attr_accessor :name

	def initialize(name)
		@name = name
	end

end

class Hangman
	attr_accessor :turn, :secret_word

	def initialize
		@turn = 0
		@secret_word = dictionary
		@guessed_letters = []
		@empty_letters = []
	end

	#this will read through the 5desk.txt file and generate a random word between 5 - 12 characters long
	def dictionary
		words = File.read("../5desk.txt")
		random_words = []

		words.split().each do |w| 
			if w.size >= 5 && w.size <= 12
				random_words << w
			end
		end
		secret_word = random_words.sample.downcase.split("").to_a
		return secret_word		
	end

	#Game options for the Player
	def menu
		puts "What would you like to do next?"
		puts "Please selection an option from below"
		puts "Press 1 for a 'New Game'"
		puts "Press 2 to load a 'Saved Game'"
		puts "Press 3 to view the credits"
		menu_input = gets.chomp.to_i
		menu_option(menu_input)
	end

	def menu_option(menu_input)
		if menu_input == 1
			play_game
		elsif menu_input == 2
			puts "Game loaded successfully!"
			load_game
		else menu_input == 3
			credits
		end
	end
			

	#starts the game
	def start_game
		puts ""
		puts "||================================||"
		puts "||Welcome to the game of Hangman!!||"
		puts "||================================||"
		puts "In this game of Hangman you'll have 12 chances to guess the secret word!"
		puts "Every correct & incorrect letter will be reflected after the round"
		puts "Let's begin!"
		puts "What is your name?"
		name = gets.chomp.capitalize
		@player = Player.new(name)
		puts "Hello #{name}!"
		menu
	end

	#this is where the input checks to see if player has won
	def play_game
		while @turn < 13
			puts "#{@player.name}, please enter your guess. Remember, one character at a time"
			puts "If you would like to Save the game at any time, please type 'save'"
			guess = gets.chomp.downcase
			current_display = answer(guess)
			if current_display == @secret_word
				puts "||~~~~~~~~~~||"
				puts "||~You won!~||"
				puts "||~~~~~~~~~~||"
				puts "You guess the secret word: #{@secret_word.join("")}"
				exit
			else
				puts "You haven't solved the answer just yet."
				puts "Here is the current status of the game.....#{current_display}"
				puts "Here are the used already used #{@empty_letters}"
				puts "Keep trying!"
				puts "-------------------"
				puts "That was turn number " + @turn.to_s
				play_game
			end
			game_over
		end
	end

	def game_over
		puts "You lost!"
		puts "The secret word was #{@secret_word.join("")}"
		exit
	end

	def answer(guess)
		if @secret_word.include?(guess)
			puts "Great guess!"
			@guessed_letters << guess
			display_word
		elsif
			@empty_letters.include?(guess)
			puts "You've guessed that already!"
			display_word
		elsif guess == 'save'
			save_game
		else
			puts "Oops!! Incorrect"
			@empty_letters << guess
			@turn += 1
			display_word
		end
	end

	def display_word
		current_display = []
		@secret_word.each do |letter|
			if @guessed_letters.include?(letter)
				current_display << letter
			elsif
				current_display << "-"
			else
				puts @empty_letters
			end
		end
		current_display.to_a
	end

	def save_game
		Dir.mkdir('../saved_games') unless Dir.exists?("../saved_games")
		puts "Please name your save file"
		save_title = gets.chomp
		saved_game = YAML::dump(self)
		save = File.new("../saved_games/#{save_title}.yaml", "w")
		save.write(saved_game)
		save.close
		puts "Beep boop!"
		puts "Boop beep!"
		puts "Game is saved..."
		exit
	end

	def load_game
		saved_files	= Dir.foreach("../saved_games/") {|entry| puts entry }
		puts saved_files
		puts "What game would you like to load?"		
		load_game = gets.chomp
		load_game = File.open("../saved_games/#{load_game}.yaml","r")
		game = File.read(load_game)
		YAML::load(game).play_game
	end

	def credits
		puts "~~~~~~~~~~~~~~~~~~~~~"
		puts "~~~~~~~~~~~~~~~~~~~~~"
		puts "Created for The Odin Project"
		puts "~~~~~~~~~~~~~~~~~~~~~"
		puts "~~~~~~~~~~~~~~~~~~~~~"		
		puts "•_•)"
		puts "( •_•)>⌐■-■"
		puts "(⌐■_■)"
		puts " © Saul Ocampo"
		puts "~~~~~~~~~~~~~~~~~~~~~"
		puts "~~~~~~~~~~~~~~~~~~~~~"
	end
end

game = Hangman.new
game.start_game