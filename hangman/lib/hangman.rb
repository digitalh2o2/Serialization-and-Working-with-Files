#hangman class that will hold the methods
class Hangman
	attr_accessor :turn, :secret_word

	def initialize
		@turn = 0
		@secret_word = dictionary
		@guessed_letters = []
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


	def instructions
		puts "In this game of Hangman you'll have 12 chances to guess the secret word!"
		puts "Every correct & incorrect letter will be reflected after the round"
		puts "Let's begin!"
	end

	#starts the game
	def start_game
		puts ""
		puts "||================================||"
		puts "||Welcome to the game of Hangman!!||"
		puts "||================================||"
		instructions
		puts "What is your name?"
		name = gets.chomp.capitalize
		puts "Hello #{name}!"
		play_game
	end

	#this is where the input checks to see if player has won
	def play_game
		while @turn < 13
			puts "Please enter your guess. Remember, one character at a time"
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
		else
			puts "Oops!! Incorrect"
			@turn += 1
			display_word
		end
	end

	def display_word
		current_display = []
		@secret_word.each do |letter|
			if @guessed_letters.include?(letter)
				current_display << letter
			else
				current_display << "-"
			end
		end
		current_display.to_a
	end

end

game = Hangman.new
game.start_game