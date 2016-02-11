#hangman class that will hold the methods
class Hangman
	attr_accessor :turn

	def initialize
		@turn = 0
	end
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
		puts "In this game of Hangman you'll have 10 chances to guess the secret word!"
		puts "Every correct & incorrect letter will be reflected after the round"
		puts "Let's begin!"
	end

	#starts the game
	def start_game
		print dictionary
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
		puts "Please enter your guess. Remember, one character at a time"
		guess = gets.chomp.downcase
		feedback = answer(guess)
		if feedback == dictionary
			puts "||~~~~~~~~~~||"
			puts "||~You won!~||"
			puts "||~~~~~~~~~~||"
		else
			puts "You haven't solved the answer just yet."
			puts "Here is the current status of the game.....#{feedback}"
			puts "Keep trying!"
			puts "-------------------"
			@turn += 1
			puts "That was turn number " + @turn.to_s
			start_game
		end
		puts "You reached the max turns of 10!"
	end

	#will compare players guess with random word
	def answer(guess)
		feedback = []
		guess.each_with_index { |letter, index|
			if dictionary.include?(letter)
				if dictionary[letter] == guess[letter]
					feedback << letter
				else
					feedback << "-"
				end
			end
		}
		feedback.to_a
	end

start_game