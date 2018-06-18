require 'pry'

class BookBytes::CLI
  attr_accessor :viewed_likes

  def call
    @viewed_likes = false
    hello
    BookBytes::Genre.generate_genres
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

    if input.to_i > 0 && index < genres.length
      genre_name = genres[index].name
      print_byte(genre_name)
    elsif input.downcase == "list"
      list_genres
    elsif input.downcase == "exit"
      goodbye
    else
      puts "Hmm, that input seems to be invalid. Please try again."
      select_genre_prompt
    end
  end

  def print_byte(genre_name)
    @viewed_likes = false

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

    swipe_prompt
  end

  def swipe_prompt
    puts "Please enter your selection, type 'back' to go back to the genre list, or type 'exit'."
    puts
    puts "[Y] I like it! Get the title and author"
    puts "[N] Get a different #{BookBytes::Genre.current.name} byte"
    puts
    
    get_swipe_input
  end

  def get_swipe_input
    case gets.chomp.downcase
    when "y", "yes"
      BookBytes::Book.shown.last.swiped = true
      BookBytes::Book.reveal_info
      sleep 3
      reprompt
    when "n", "no"
      print_byte(BookBytes::Genre.current.name)
    when "back", "list"
      list_genres
    when "exit"
      goodbye
    else
      puts
      puts "Hmm, please enter valid input"
      puts
      get_swipe_input
    end
  end

  def reprompt
    messages = ["Glad you dig it!", "Yay for books!", "Book yeah!", "We like that one too!", "Love at first byte!"]

    if self.viewed_likes == false
      puts "-------------------------------"
      puts
      puts messages[rand(messages.length)]
    end
    puts
    puts "[1] Get a different #{BookBytes::Genre.current.name} byte"
    puts "[2] Go back to the genre list"
    puts "[3] See all the books you've liked" if self.viewed_likes == false
    puts
    puts "Please enter your selection or type 'exit'"
    puts
    get_reprompt_input
  end

  def get_reprompt_input
    case gets.chomp.downcase
    when "1"
      print_byte(BookBytes::Genre.current.name)
    when "2", "back", "list"
      list_genres
    when "3"
      @viewed_likes = true
      get_swiped_books
    when "exit"
      goodbye
    else
      puts "Hmm, that's not valid input. Try again."
      puts
      get_reprompt_input
    end
  end

  def get_swiped_books
    swiped_books = BookBytes::Book.shown.select {|book| book.swiped == true}

    puts "You have liked this book:" if swiped_books.length == 1
    puts  "You have liked these books:" if swiped_books.length > 1
    puts
    swiped_books.each_with_index do |b, i|
      if swiped_books.length == 1
        print "*** "
      else
        print "#{i + 1}) "
      end

      print "'#{b.title}' by #{b.author}"
      puts
    end

    puts
    puts "-------------------------------"
    sleep 3

    reprompt
  end
      
  def goodbye
    puts
    puts "Book excerpts courtesy of bookdaily.com"
    puts "Thanks for stopping by :)"
    puts
  end
end
