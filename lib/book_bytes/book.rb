require 'pry'

class BookBytes::Book
  attr_accessor :title, :author, :genre, :text, :swiped
    
  @@shown = []
 
  # Keep track of and be able to return which books have been shown and for which more information has been requested
  # option to show this at the end
  # current book is always last in @@shown array
  def initialize(title, author, genre, text)
    @title = title
    @author = author
    @genre = genre # this is object
    @text = text
    @swiped = false
  end

  def self.shown
    @@shown
  end

  def self.create_new_book(title, author, genre, text)
    new_book = self.new(title, author, genre, text)
    
    @@shown << new_book
    new_book
  end

  # def self.get_random_text(genre_name)
  #   BookBytes::Scraper.get_book_details(genre_name)
    
  #   # random_book = BookBytes::Genre.find_genre(genre_name).books.shuffle[0]
  #   # @@curr_book = random_book
  #   # puts random_book.text
  #   # random_book
  # end
  
  def self.curr_book
    @@curr_book
  end

  def self.reveal_info
    puts
    puts "And your requested info is..."
    puts
    sleep 2
    puts "*** Title: #{@@shown.last.title}"
    puts "*** Author: #{@@shown.last.author}"
    puts
  end

  def self.all
    @@all
  end
end
