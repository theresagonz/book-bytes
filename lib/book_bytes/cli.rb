require 'pry'

module BookBytes
  class CLI
    def call
      hello
      cat_prompt
      list_cats
      cat_menu
    end

    def hello
      puts ""
      puts "*** WELCOME TO BOOKBYTES ***"
      puts "Find new favorite reads!"
      puts ""
    end

    def cat_prompt
      puts "Please enter a number that corresponds to your selected genre, type 'list' to see the list again, or type 'exit'."
      puts ""
    end
      
    def list_cats
      # this is a here doc --> makes a big string
      puts <<-DOC.gsub /^\s*/, ""
      GENRES:
      1. literary
      2. humor
      3. mystery
      4. sci-fi & fantasy
      5. biography & memoirs
      DOC
      # 6. social sciences
      # 7. history
      # 8. arts & photography
      # 9. philosophy
      # 10. outdoors & nature
    end
      
    def cat_menu
      input = nil
      
      while input != "exit"
        input = gets.chomp.downcase
        case input
        when "1"
          puts "Here's the beginning of a literary book:"
          puts ""
        when "2"
          puts "Here's the beginning of a humor book:"
          puts ""
        when "3"
          puts "Here's the beginning of a mystery book:"
          puts ""
        when "4"
          puts "Here's the beginning of a sci-fi/fantasy book:"
          puts ""
        when "5"
          puts "Here's the beginning of a biography/memoir:"
          puts ""
        when "list"
          list_cats
        else
          puts "Hmm, that's not a valid selection. Try again." unless input == "exit"
        end
      end
    end
      
    def goodbye
      puts "Farewell and keep on readin!"
    end
  end
end
