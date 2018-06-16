require 'pry'

class BookBytes::Genre
  attr_accessor :name
    
  @@all = []
  @@current = nil

  def initialize(name)
    @name = name
    # @books = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.current
    @@current
  end
  
  def self.generate_genres
    genre_names = ["Arts & Photography", "Biographies & Memoirs", "Cooking, Food & Wine", "History", "Humor & Entertainment", "Literature & Fiction", "Mystery & Thrillers", "Outdoors & Nature", "Politics & Social Sciences", "Romance", "Science", "Science Fiction & Fantasy", "Self-Help", "Sports", "Travel"]

    genre_names.each {|name| self.new(name) if !self.find_genre(name)}
  end
  
  def self.find_genre(genre_name)
    @@current = self.all.find {|g| g.name == genre_name}
    self.current
  end
end
