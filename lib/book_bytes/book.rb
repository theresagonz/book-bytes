class BookBytes::Book
  attr_accessor :title, :author, :genre, :text
    
  @@all = [] 

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end
end
