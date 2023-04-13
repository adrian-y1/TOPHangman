require 'yaml'

# Saves the game using YAML with user's provided filename
def save_game(game)
    class_objects = YAML::dump(game)
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')

    puts "Enter a name for the file:"
    user_input = gets.to_s
    filename = "saved_games/#{user_input.strip}.yml"

    File.open(filename, 'w') do |file|
        file.puts class_objects
    end
end

# Creates the game
class Game
    attr_accessor :choice, :secret_word, :lives, :result_arr, :used_letters, :lowercase, :guess

    def initialize
        get_choice
        execute_choice
    end

    # Exectues the option user chose and plays the game accordingly
    def execute_choice
        if @choice == '1'
            play_new_game
        elsif @choice == '2'
            get_file
            play_loaded_game
        end
    end

    # Asks the user for the file they want to load
    def get_file
        puts "Here are all the saved games."
        puts Dir.glob('saved_games/**/*').select {|f| File.file? f}.map{|f| File.basename f}
        puts "\nEnter the name of the game/file you want to load:"
        @get_filename = gets.to_s.strip
        until File.exist?("saved_games/#{@get_filename}")
            puts "\nPlease enter the full file name as it appears."
            puts "Enter the name of game you want to load:"
            @get_filename = gets.to_s.strip
        end
    end

    # Plays a pre-saved game
    def play_loaded_game
        load_saved_game
        display_progress
        play
    end

    # Plays a new game by loading in the dictionary and randomly chooses a secret word
    def play_new_game
        dictionary = File.read('google-10000-english-no-swears.txt')
        @secret_word = dictionary.lines.select { |w| w.strip.length >= 5 && w.strip.length <= 12 }.sample
        @lives = 6
        board
        @used_letters = []
        play
    end

    # Plays the game until user is out of lives or has guessed the word
    def play
        until @lives == 0 || @result_arr.join('') == @secret_word.strip
            get_guess
            if @secret_word.include?(@guess.downcase)
                puts "\nCorrect!\n"
                correct_letter
            else
                puts "\nIncorrect!\n"
                @lives -= 1
            end
            @used_letters.push(@guess.downcase) if @guess.length == 1
            display_progress
            if lost? || word_found?
                break
            end
        end
    end

    # Loads the requested saved file and assigns all the objects to the current instance
    def load_saved_game
        load_file = YAML.load_file("saved_games/#{@get_filename}", permitted_classes: [Game, Symbol, Range])
        @choice = load_file.choice
        @secret_word = load_file.secret_word
        @lives = load_file.lives
        @result_arr = load_file.result_arr
        @used_letters = load_file.used_letters
        @lowercase = load_file.lowercase
        @guess = load_file.guess
    end

    # Gets the user's choice of whether they want to play new game
    # or load existing one
    def get_choice
        puts "Press 1 to play a new game, press 2 to load a saved game."
        @choice = gets.to_s.strip
        until @choice == '1' || @choice == '2'
            puts "Invalid Input!"
            puts "Please Press 1 to play the game, press 2 to load a game."
            @choice = gets.to_s.strip
        end
    end

    # Gets the user's guess and validates it before continuing. 
    # If the user types the word 'save', the game is saved and exited
    def get_guess
        puts "\n#{@lives} lives remaining"
        puts "Enter your guess or type 'save' to save the game:"
        @lowercase = ('a'..'z')
        @guess = gets.to_s.strip
        until @lowercase.include?(@guess.downcase) && !@used_letters.include?(@guess.downcase) || @guess.downcase == 'save'
            puts "\nInvalid Input, please try again.\n\n"
            puts "#{@lives} lives remaining"
            puts "Enter your guess or type 'save' to save the game:"
            @guess = gets.to_s.strip
        end
        if @guess.downcase == 'save'
            @guess = ''
            save_game(self)
            exit
        end
    end
    
    # Checks if the user has found the word and has lives remaining
    def word_found?
        if @lives > 0 && @result_arr.join('') == @secret_word.strip
            puts "\nPlayer Won! The player has found the word."
            puts "The word was -> #{@secret_word}"
        end
    end

    # Checks if the user is out of lives and has not found the secret word
    def lost?
        if @lives == 0 && !word_found?
            puts "\nGame Over! The player is out of lives." 
            puts "The word was -> #{@secret_word}"
        end
    end

    # If the guess is correct, stores the letter at that index in the result_arr
    def correct_letter
        # Turn secret word into array and loop over it
        # For every match with the player's guess, change the result_arr's value at that index
        @secret_word.split('').each_with_index do |letter, index|
            if letter == @guess.downcase
                @result_arr[index] = @guess.downcase
            end
        end
    end

    # Displays the progress afte reach guess
    def display_progress
        puts "\n#{@result_arr.join(' ')}"
        puts "\nLetters used: #{@used_letters.join(", ")}" if @used_letters.length > 0
    end

    # Displays the secret word's letters hidden
    def board
        puts "\nThe computer has chosen a secret word. You have 6 chances to figure it out."
        @result_arr = Array.new(@secret_word.strip.length)
        @result_arr.map! {|v| '_'}
        puts @result_arr.join(' ')
    end
end

game = Game.new