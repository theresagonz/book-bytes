require 'pry'

class BookBytes::Book
  attr_accessor :title, :author, :genre, :text, :swiped
    
  @@shown = []
 
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
    # can i use tap here?
    new_book = self.new(title, author, genre, text)
    
    @@shown << new_book
    new_book
  end

  def self.reveal_info
    puts
    puts "Getting your requested info..."
    puts
    sleep 2
    puts "*** Title: #{self.shown.last.title}"
    puts "*** Author: #{self.shown.last.author}"
    puts
  end

  def self.all
    @@all
  end
end
