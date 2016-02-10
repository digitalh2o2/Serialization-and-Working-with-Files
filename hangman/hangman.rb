#hangman class that will hold the methods
class Hangman
	attr_accessor :name

	def initialize(name)
		@name = name
	end
end

def dictionary
	words = File.readlines("5desk.txt")
	random = words.select {|w| w.size >= 4 && w.size <= 13}.sample
end

def start_game
	puts "Welcome to the game of Hangman!!"
	puts "What is your name?"
	name = gets.chomp.capitalize
	@name = Hangman.new(name)
	puts "Hello #{@name.name}!"
	puts dictionary	
end

start_game