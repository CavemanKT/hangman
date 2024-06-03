class Hangman
    def initialize
        @letter = ('a'..'z').to_a
        @word = words.sample
        @lives = 7
        @correct_guesses = []

        @word_teaser = ""
        @word.first.size.times do
            @word_teaser += "_ "
        end
    end

    def words
        [
            ["cricket", "use bar to hit the ball"],
            ["basketball", "use hand to grab the ball"],
            ["baseball", "use bat to hit the ball"],
            ["tennis", "use racket to hit the ball"],
            ["volleyball", "use hand to hit the ball"],
        ]
    end

    def print_teaser last_guess = nil
        update_teaser(last_guess) unless last_guess.nil?
        puts @word_teaser
    end

    def update_teaser last_guess
        new_teaser = @word_teaser.split
        new_teaser.each_with_index do |char, index|
            if char == "_" && @word.first[index] == last_guess
                new_teaser[index] = last_guess
            end
        end
        @word_teaser = new_teaser.join(" ")
    end


    def make_guess
        if @lives > 0 and @word_teaser.include?("_")
            puts "Enter a letter: "
            guess = gets.chomp
            # if letter is not part of the word then remove from letter array
            good_guess = @word.first.include?(guess)
            if good_guess
                puts "Good guess!"
                @correct_guesses << guess
                # remove correct guess from letter array
                @letter.delete guess
                print_teaser guess
                if @word_teaser == @word.first
                    puts "You win!"
                else
                    make_guess
                end
            else
                @lives-=1
                puts "Wrong, you have #{@lives} lives left."
                make_guess
            end
        elsif !@word_teaser.include?("_")
            puts "You won!"
        else
            puts "You lose!"
        end
    end

    def begin
        # ask user for a letter
        puts "New game started... Your word is #{ @word.first.size } characters long" 
        print_teaser @word_teaser

        puts "Clue: #{ @word.last }"
        make_guess
    end

end

game = Hangman.new
game.begin
