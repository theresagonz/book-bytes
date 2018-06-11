require 'pry'

class BookBytes::Genre
  attr_accessor :name, :books
    
  @@all = []

  def initialize(name)
    @name = name
    @books = []
    @@all << self
  end

  def self.all
    @@all
  end
  
  def self.generate_genres
    # genres should be a hash - genres[:books] is an array of actual stored book instances?
    genre_names = ["art/photography", "biography/memoir", "cooking/food", "history", "humor", "literary", "mystery", "outdoors/nature", "romance", "sci-fi/fantasy", "science", "self-help", "social science", "sports", "travel"]
    
    # creates new genres
    genre_names.each {|name| self.new(name) if !self.find_genre(name)}
  end
  
  def self.find_genre(genre_name)
    self.all.find {|g| g.name == genre_name}
  end
end
