require 'pry'

class BookBytes::CLI
  def call
    hello
    cat_prompt
    list_cats
    cat_menu
  end

  def hello
    puts
    puts "-----------------------------"
    puts "*** WELCOME TO BOOKBYTES! ***"
    puts "Discover super cool new reads"
    puts "-----------------------------"
    puts
  end

  def cat_prompt
    puts "Pick a genre, any genre!"
    puts
  end
    
  def list_cats
    BookBytes::Genre.generate_genres

    puts "-----------------------------"
    puts "*** GENRES ***"
    BookBytes::Genre.all.each_with_index do |g, i|
      puts "#{i + 1}. #{g.name}"
    end

    puts
    puts "Enter the number of your selection, type 'list' to see the list again, or type 'exit'."
    puts
  end
    
  def cat_menu
    input = nil
    
    while input != "exit"
      input = gets.chomp.downcase
      index = input.to_i - 1
      genre_array = BookBytes::Genre.all

      BookBytes::Book.generate_books

      if input.to_i > 0 && index < genre_array.length
        genre_name = genre_array[index].name

        if index != 4
          puts "Here's the beginning of a #{genre_name} book:"
          puts
          puts BookBytes::Genre.rand_text(genre_name)
          puts
        else
          puts "Here's the beginning of a #{genre_name}:"
          puts
          puts BookBytes::Genre.rand_text(genre_name)
          puts 
        end
      elsif input == "list"
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
