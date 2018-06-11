require 'pry'

class BookBytes::Book
  attr_accessor :title, :author, :genre, :text, :swipe
    
  @@chosen = []
 
  # Keep track of and be able to return which books have been shown and for which more information has been requested
  # option to show this at the end
  # current book is always last in @@chosen array
  def initialize(title, author, genre, text)
    @title = title
    @author = author
    @genre = genre # this is object
    @text = text
    @swipe = false
  end

  def self.chosen
    @@chosen
  end

  def self.create_new_book(title, author, genre, text)
    new_book = self.new(title, author, genre, text)
    
    @@chosen << new_book
    new_book
  end

  def self.random_text(genre_name)
    random_book = BookBytes::Genre.find_genre(genre_name).books.shuffle[0]
    @@curr_book = random_book
    # puts random_book.text
    random_book
  end
  
  def self.curr_book
    @@curr_book
  end

  def self.reveal_info
    puts "And your requested info is..."
    puts
  #   book_array.each {|b| self.add_or_skip_book(b[:title], b[:author], b[:text], b[:genre].name)}
  # end
    sleep 2
    puts "*** Title: #{curr_book.title}"
    puts "*** Author: #{curr_book.author}"
    puts
  end

  def self.all
    @@all
  end
end
