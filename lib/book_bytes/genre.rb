require 'pry'

class BookBytes::Genre
  attr_accessor :name
    
  @@all = []

  def initialize(name)
    @name = name
    # @books = []
    @@all << self
  end

  def self.all
    @@all
  end
  
  def self.generate_genres
    # genres should be a hash - genres[:books] is an array of actual stored book instances?
    
    # creates new genres
    genre_names = ["Arts & Photography", "Biographies & Memoirs", "Cooking, Food & Wine", "History", "Humor & Entertainment", "Literature & Fiction", "Mystery & Thrillers", "Outdoors & Nature", "Politics & Social Sciences", "Romance", "Science", "Science Fiction & Fantasy", "Self-Help", "Sports", "Travel"]

    genre_names.each {|name| self.new(name) if !self.find_genre(name)}
  end
  
  def self.find_genre(genre_name)
    self.all.find {|g| g.name == genre_name}
  end
end
