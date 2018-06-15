require 'pry'

class BookBytes::CLI
  attr_accessor :viewed_likes

  def call
    @viewed_likes = false
    hello
    list_genres
  end

  def hello
    puts
    puts "-------------------------------"
    puts "***** WELCOME TO BOOKBYTES ****"
    puts "Book serendipity in small bytes"
    puts "-------------------------------"
    puts
    puts "    Pick a genre, any genre"
    puts
  end
    
  def list_genres
    BookBytes::Genre.generate_genres

    puts "-------------------------------"
    puts "      *** GENRES ***"
    BookBytes::Genre.all.each_with_index do |g, i|
      puts "[#{i + 1}] #{g.name}"
    end
    select_genre_prompt
  end

  def select_genre_prompt
    puts
    puts "Enter the number of your selection, type 'list' to see the list again, or type 'exit'."
    puts
    get_genre_input
  end
    
  def get_genre_input
    input = gets.chomp.downcase
    index = input.to_i - 1
    genres = BookBytes::Genre.all

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
      select_genre_prompt
      get_genre_input
    end
  end

  def print_byte(genre_name)
    @viewed_likes = false
    # if the first letter starts with a vowel, make the sentence more grammatically correct
    if genre_name[0,1].downcase.match(/[aeiou]/)
      puts "Here's the beginning of an #{genre_name} book:"
    else
      puts "Here's the beginning of a #{genre_name} book:"
    end
    puts "-------------------------------"
    puts
    puts BookBytes::Scraper.get_random_book(genre_name).text
    puts
    puts "-------------------------------"
    sleep 7
  end

  def swipe_prompt
    puts "Please enter your selection, type 'back' to go back to the genre list, or type 'exit'"
    puts
    puts "[Y] I like it! Get the title and author"
    puts "[N] Get a different #{BookBytes::Genre.current.name} byte"
    puts
    get_swipe_input
  end

  def get_swipe_input
    input = gets.chomp

    case input.downcase
    when "y"
      BookBytes::Book.shown.last.swiped = true
      BookBytes::Book.reveal_info
      sleep 3
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
    messages = ["Glad you dig it!", "Yay for books!", "Book yeah!", "We like that one too!", "Love at first byte!"]
    # don't display this if you've already seen it for this book
    if self.viewed_likes == false
      puts "-------------------------------"
      puts
      puts messages[rand(messages.length)]
    end
    puts
    puts "[1] Get a different byte in the same genre"
    puts "[2] Go back to the genre list"
    puts "[3] See all the books you've liked" if self.viewed_likes == false
    puts
    puts "Please enter your selection or type 'exit'"
    puts
    case gets.chomp
    when "1"
      print_byte(BookBytes::Genre.current.name)
      swipe_prompt
    when "2" || "back" || "list"
      list_genres
    when "3"
      @viewed_likes = true

      swiped_books = BookBytes::Book.shown.select {|book| book.swiped == true}

      puts "You have liked this book:" if swiped_books.length == 1
      puts  "You have liked these books:" if swiped_books.length > 1
      puts
      swiped_books.each_with_index do |b, i|
        if swiped_books.length == 1
          puts "*** '#{b.title}' by #{b.author}"
        else
          puts "#{i + 1}) '#{b.title}' by #{b.author}"
        end
      end
        puts
        puts "-------------------------------"
      sleep 3
      reprompt

    when "exit"
      goodbye
    else
      puts "Hmm, that's not valid input. Try again."
      puts
      reprompt
    end
  end
      
  def goodbye
    puts
    puts "Book excerpts courtesy of bookdaily.com"
    puts "Thanks for stopping by :)"
    puts
  end
end
