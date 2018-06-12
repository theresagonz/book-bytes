require 'pry'

class BookBytes::CLI
  def call
    hello
    first_prompt
    list_genres
  end

  def hello
    puts
    puts "-------------------------------"
    puts "***** WELCOME TO BOOKBYTES ****"
    puts "Book serendipity in small bytes"
    puts "-------------------------------"
    puts
  end

  def first_prompt
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
    second_prompt
  end

  def second_prompt
    puts
    puts "Enter the number of your selection, type 'list' to see the list again, or type 'exit'."
    puts
    parse_input
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
        swipe_prompt
      elsif input.downcase == "list"
        list_genres
      elsif input.downcase == "exit"
        goodbye
      else
        puts "Hmm, that input seems to be invalid. Please try again."
        second_prompt
        parse_input
      end
    end

  def print_byte(genre_name)
    puts "Here's the beginning of a #{genre_name} book:"
    puts
    puts "-------------------------------"
    puts
    # so that text will kind of be printed really fast instead of just appearing. Might make program slower tho
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
    puts "Please enter your selection, type 'back' to go back to the genre list, or type 'exit'"
    puts
    puts "[Y] I like it! Get the title and author"
    puts "[N] Get another!"
    puts
    input = gets.chomp

    case input.downcase
    when "y"
      BookBytes::Book.shown.last.swiped = true
      BookBytes::Book.reveal_info
      sleep 1.5
      reprompt
    when "n"
      print_byte(BookBytes::Genre.current.name)
      swipe_prompt
    when "back"
      list_genres
    when "exit"
      goodbye
    else
      puts
      puts "Hmm, please enter valid input"
      puts
      swipe_prompt
    end
  end

  def reprompt
    puts "-------------------------------"
    puts "So glad you liked the byte!"
    puts
    puts "[1] Get a different byte in the same genre"
    puts "[2] Go back to the genre list"
    puts
    puts "Please enter your selection or type 'exit'"
    puts
    case gets.chomp
    when "1"
      print_byte(BookBytes::Genre.current.name)
      reprompt
    when "2" || "back" || "list"
      list_genres
    when "exit"
      goodbye
    else
      puts "Hmm, that's not valid input. Try again."
      puts
      reprompt
    end
  end
      
  def goodbye
    puts "Farewell and keep on readin!"
  end
end
