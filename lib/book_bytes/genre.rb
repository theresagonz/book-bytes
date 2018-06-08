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
    genre_names = ["literary", "humor", "mystery", "sci-fi & fantasy", "biography & memoir", "social science", "history", "arts", "philosophy", "nature"]
    
    # creates new genres
    genre_names.each {|name| self.new(name)}
  end

  def self.find_genre(genre_name)
    self.all.find {|g| g.name == genre_name}
  end
end
