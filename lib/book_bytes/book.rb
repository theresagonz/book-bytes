class BookBytes::Book
  attr_accessor :title, :author, :genre, :text
    
  @@all = [] 

  def initialize
    @@all << self
  end
  
  def self.add_book(title, author, genre, text)
    new_book = self.new
    new_book.title = title
    new_book.author = author
    new_book.text = text
    new_book.genre = BookBytes::Genre.all.detect {|g| g.name == genre}
    
    new_book.genre.books << new_book
    self.all << new_book
  end

  def self.all
    @@all
  end
end

# Actual book details will be added in the Scraper class
