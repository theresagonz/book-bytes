class BookBytes::Genre
  attr_accessor :name, :books
    
  @@all = []

  def initialize
    @books = []
    @@all << self
  end

  def self.all
    @@all
  end
end
