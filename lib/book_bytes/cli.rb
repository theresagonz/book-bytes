require 'pry'

class BookBytes::CLI
  def call
    BookBytes::Genre.generate_genres
    BookBytes::Scraper.get_book_details
    hello
    cat_prompt
    list_cats
    cat_menu
    goodbye
  end

  def hello
    puts
    puts "-------------------------------"
    puts "***** WELCOME TO BOOKBYTES ****"
    puts "Book serendipity in small bytes"
    puts "-------------------------------"
    puts
  end

  def cat_prompt
    puts "   Pick a genre, any genre!"
    puts
  end
    
  def list_cats
    BookBytes::Genre.generate_genres

    puts "-------------------------------"
    puts "      *** GENRES ***"
    BookBytes::Genre.all.each_with_index do |g, i|
      puts "#{i + 1}. #{g.name}"
    end

    puts
    puts "Enter the number of your selection, type 'list' to see the list again, or type 'exit'."
    puts
  end
    
  def cat_menu
    input = nil
    
    # while input != "exit"
      input = gets.chomp.downcase
      index = input.to_i - 1
      genre_array = BookBytes::Genre.all
    # based on the input scrape just selected page for all books
      BookBytes::Book.generate_books
      # 
BookBytes::Scraper.genres[]
      if input.to_i > 0 && index < genre_array.length
        genre_name = genre_array[index].name
        print_byte(genre_name)
        # puts "-----------------------------"
        prompt
      elsif input.downcase == "list"
        list_cats
      elsif input.downcase == "exit"
      else
      end
    end
  # end

  def print_byte(genre_name)
    puts "Here's the beginning of a #{genre_name} book:"
    puts
    puts "-------------------------------"
    puts
    BookBytes::Book.random_text(genre_name).text.split(//).each do |character|
      print character
      sleep 0.0003
    end
    puts
    puts
    puts "-------------------------------"
    # sleep 10
  end

  def prompt
    puts "Please enter your choice or type 'exit'"
    puts "1. I like it! Get the title and author"
    puts "2. Get a different snippet in the same genre"
    puts "3. Choose a different genre"
    puts "4. Exit the program"
    puts
    input = gets.chomp

    case input
    when "1"
      BookBytes::Book.reveal_info
      sleep 1.5
      reprompt
    when "2"
      print_byte(BookBytes::Book.curr_book.genre.name)
      prompt
    when "3"
      list_cats
      cat_menu
    when "4" || "exit"
      goodbye
    end
  end

  def reprompt
    puts "-------------------------------"
    puts "So glad you liked the snippet!"
    puts "1. Get a different snippet in the same genre"
    puts "2. Choose a different genre"
    puts "3. Exit the program"

    case gets.chomp
    when "1"
      print_byte(BookBytes::Book.curr_book.genre.name)
      reprompt
    when "2"
      list_cats
      cat_menu
    when "3" || "exit"
      goodbye
    end
  end
      
  def goodbye
    puts "Farewell and keep on readin!"
  end
end
