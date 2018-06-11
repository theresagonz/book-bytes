require 'pry'

class BookBytes::Book
  attr_accessor :title, :author, :genre, :text, :curr_book
    
  @@all = []
  @@curr_book = nil
  
  def initialize(title, author, genre, text)
    @title = title
    @author = author
    @genre = genre # this is object
    @text = text
    
    # @@curr_book = nil
    @@all << self
  end
  
  def self.add_book(title, author, text, genre_name)
    genre = BookBytes::Genre.find_genre(genre_name)
    
    new_book = self.new(title, author, genre, text) if !self.all.include?(new_book)
    genre.books << new_book
  end

  def self.add_or_skip_book(title, author, text, genre_name)
    if self.all.none? {|b| b.title == title && b.author == author && b.genre.name == genre_name}
      self.add_book(title, author, text, genre_name)
    end
  end

  # hardcoded data for initial testing
  def self.generate_books
    book_array = [{
      title: "Thinking Fast and Slow",
      author: "Daniel Kahneman",
      text: "To observe your mind in automatic mode, glance at the image below.
      Figure 1
      Your experience as you look at the woman's face seamlessly combines what we normally call seeing and intuitive thinking. As surely and quickly as you saw that the young woman's hair is dark, you knew she is angry. Furthermore, what you saw extended into the future. You sensed that this woman is about to say some very unkind words, probably in a loud and strident voice. A premonition of what she was going to do next came to mind automatically and effortlessly. You did not intend to assess her mood or to anticipate what she might do, and your reaction to the picture did not have the feel of something you did. It just happened to you. It was an instance of fast thinking.",
      genre: BookBytes::Genre.find_genre("social science")
    },
    {
      title: "Life of Pi",
      author: "Yann Martel",
      text: "My suffering left me sad and gloomy. Academic study and the steady, mindful practice of religion slowly brought me back to life. I have remained a faithful Hindu, Christian and Muslim. I decided to stay in Toronto. After one year of high school, I attended the University of Toronto and took a double-major Bachelor's degree. My majors were religious studies and zoology. My fourth-year thesis for religious studies concerned certain aspects of the cosmogony theory of Isaac Luria, the great sixteenth-century Kabbalist from Safed. My zoology thesis was a functional analysis of the thyroid gland of the three-toed sloth. I chose the sloth because its demeanour-calm, quiet and introspective-did something to soothe my shattered self.",
      genre: BookBytes::Genre.find_genre("mystery")
    },
    {
      title: "The Hitchhiker's Guide to the Galaxy",
      author: "Douglas Adams",
      text: "The house stood on a slight rise just on the edge of the village. It stood on its own and looked out over a broad spread of West Country farmland. Not a remarkable house by any means—it was about thirty years old, squattish, squarish, made of brick, and had four windows set in the front of a size and proportion which more or less exactly failed to please the eye.
      The only person for whom the house was in any way special was Arthur Dent, and that was only because it happened to be the one he lived in. He had lived in it for about three years, ever since he had moved out of London because it made him nervous and irritable. He was about thirty as well, tall, dark-haired and never quite at ease with himself. The thing that used to worry him most was the fact that people always used to ask him what he was looking so worried about. He worked in local radio which he always used to tell his friends was a lot more interesting than they probably thought. It was, too—most of his friends worked in advertising.",
      genre: BookBytes::Genre.find_genre("sci-fi/fantasy")
    },
    {
      title: "Me Talk Pretty One Day",
      author: "David Sedaris",
      text: "Anyone who watches even the slightest amount of TV is familiar with the scene: An agent knocks on the door of some seemingly ordinary home or office. The door opens, and the person holding the knob is asked to identify himself. The agent then says, 'I'm going to ask you to come with me.'

      They're always remarkably calm, these agents. If asked 'Why do I need to go anywhere with you?' they'll straighten their shirt cuffs or idly brush stray hairs from the sleeves of their sport coats and say, 'Oh, I think we both know why.'",
      genre: BookBytes::Genre.find_genre("humor")
    },
    {
      title: "Anna Karenina",
      author: "Leo Tolstoy",
      text: "'My love keeps growing more passionate and selfish, while his is dying, and that's why we're drifting apart,' Anna says, near the end. 'He is everything to me, and I want him more and more to give himself up to me entirely. And he wants more and more to get away from me. . . . If I could be anything but a mistress, passionately caring for nothing but his caresses; but I can't and I don't care to be anything else. And by that desire I rouse aversion in him, and he rouses fury in me, and it cannot be different.'",
      genre: BookBytes::Genre.find_genre("classic")
    },
    {
      title: "Anna Karenina",
      author: "Leo Tolstoy",
      text: "'My love keeps growing more passionate and selfish, while his is dying, and that's why we're drifting apart,' Anna says, near the end. 'He is everything to me, and I want him more and more to give himself up to me entirely. And he wants more and more to get away from me. . . . If I could be anything but a mistress, passionately caring for nothing but his caresses; but I can't and I don't care to be anything else. And by that desire I rouse aversion in him, and he rouses fury in me, and it cannot be different.'",
      genre: BookBytes::Genre.find_genre("biography/memoir")
    },
    {
      title: "Anna Karenina",
      author: "Leo Tolstoy",
      text: "'My love keeps growing more passionate and selfish, while his is dying, and that's why we're drifting apart,' Anna says, near the end. 'He is everything to me, and I want him more and more to give himself up to me entirely. And he wants more and more to get away from me. . . . If I could be anything but a mistress, passionately caring for nothing but his caresses; but I can't and I don't care to be anything else. And by that desire I rouse aversion in him, and he rouses fury in me, and it cannot be different.'",
      genre: BookBytes::Genre.find_genre("art")
    },
    {
      title: "Anna Karenina",
      author: "Leo Tolstoy",
      text: "'My love keeps growing more passionate and selfish, while his is dying, and that's why we're drifting apart,' Anna says, near the end. 'He is everything to me, and I want him more and more to give himself up to me entirely. And he wants more and more to get away from me. . . . If I could be anything but a mistress, passionately caring for nothing but his caresses; but I can't and I don't care to be anything else. And by that desire I rouse aversion in him, and he rouses fury in me, and it cannot be different.'",
      genre: BookBytes::Genre.find_genre("philosophy")
    },
    {
      title: "Anna Karenina",
      author: "Leo Tolstoy",
      text: "'My love keeps growing more passionate and selfish, while his is dying, and that's why we're drifting apart,' Anna says, near the end. 'He is everything to me, and I want him more and more to give himself up to me entirely. And he wants more and more to get away from me. . . . If I could be anything but a mistress, passionately caring for nothing but his caresses; but I can't and I don't care to be anything else. And by that desire I rouse aversion in him, and he rouses fury in me, and it cannot be different.'",
      genre: BookBytes::Genre.find_genre("literary")
    },
    {
      title: "Anna Karenina",
      author: "Leo Tolstoy",
      text: "'My love keeps growing more passionate and selfish, while his is dying, and that's why we're drifting apart,' Anna says, near the end. 'He is everything to me, and I want him more and more to give himself up to me entirely. And he wants more and more to get away from me. . . . If I could be anything but a mistress, passionately caring for nothing but his caresses; but I can't and I don't care to be anything else. And by that desire I rouse aversion in him, and he rouses fury in me, and it cannot be different.'",
      genre: BookBytes::Genre.find_genre("history")
    },
    {
      title: "Anna Karenina",
      author: "Leo Tolstoy",
      text: "'My love keeps growing more passionate and selfish, while his is dying, and that's why we're drifting apart,' Anna says, near the end. 'He is everything to me, and I want him more and more to give himself up to me entirely. And he wants more and more to get away from me. . . . If I could be anything but a mistress, passionately caring for nothing but his caresses; but I can't and I don't care to be anything else. And by that desire I rouse aversion in him, and he rouses fury in me, and it cannot be different.'",
      genre: BookBytes::Genre.find_genre("mystery")
    }]

    book_array.each {|b| self.add_or_skip_book(b[:title], b[:author], b[:text], b[:genre].name)}
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
    sleep 2
    puts "*** Title: #{curr_book.title}"
    puts "*** Author: #{curr_book.author}"
    puts
  end

  def self.all
    @@all
  end
end
