require 'pry'

class BookBytes::CLI
  def call
    hello
    genre_prompt
    list_genres
    parse_input
  end

  def hello
    puts
    puts "-------------------------------"
    puts "***** WELCOME TO BOOKBYTES ****"
    puts "Book serendipity in small bytes"
    puts "-------------------------------"
    puts
  end

  def genre_prompt
    # I separated this part from list_genres so that this doesn't reprint if the user chooses to see the list again
    puts "   Pick a genre, any genre!"
    puts
  end
    
  def list_genres
    BookBytes::Genre.generate_genres

    puts "-------------------------------"
    puts "      *** GENRES ***"
    BookBytes::Genre.all.each_with_index do |g, i|
      puts "[#{i + 1}] #{g.name}"
    end

    # I want this prompt every time the list is shown
    puts
    puts "Enter the number of your selection, type 'list' to see the list again, or type 'exit'."
    puts
  end
    
  def parse_input
    input = nil
    
    # while input != "exit"
      input = gets.chomp.downcase
      index = input.to_i - 1
      genres = BookBytes::Genre.all
    # here I want to deal with all the input
      # if it's a number falling in the correct range
      if input.to_i > 0 && index < BookBytes::Genre.all.length
        genre_name = genres[index].name
        print_byte(genre_name)
        prompt
      elsif input.downcase == "list"
        list_genres
      elsif input.downcase == "exit"
      else
      end
    end

  def print_byte(genre_name)
    puts "Here's the beginning of a #{genre_name} book:"
    puts
    puts "-------------------------------"
    puts
    # so that text will kind of be printed really fast instead of just appearing. Might make program slower tho
    # BookBytes::Scraper.get_book_details()
    BookBytes::Scraper.get_random_book(genre_name).text.split(//).each do |character|
      print character
      sleep 0.0003
    end
    puts
    puts
    puts "-------------------------------"
    # sleep 10
  end

  def swipe_prompt
    puts "Please enter your choice or type 'exit'"
    puts "[y] I like it! Get the title and author"
    puts "[n] Get another!"

    puts "4. Exit the program"
    puts
    input = gets.chomp

    case input
    when "1"
      BookBytes::Book.reveal_info
      sleep 1.5
      reprompt
    when "2"
      print_byte(BookBytes::Book.chosen.last.name)
      prompt
    when "3"
      list_genres
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
      print_byte(BookBytes::Scraper.get_random_book(genre_name))
      reprompt
    when "2"
      list_genres
      cat_menu
    when "3" || "exit"
      goodbye
    end
  end
      
  def goodbye
    puts "Farewell and keep on readin!"
  end
end
