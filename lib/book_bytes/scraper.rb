require 'pry'

class BookBytes::Scraper
  attr_accessor :genre

  def self.genre
    @genre
  end

  def self.get_genres
    Nokogiri::HTML(open("http://www.bookdaily.com/browse")).css("section.genre-categories")
  end

  
  def self.get_genre_page(genre_name)
    @genre = BookBytes::Genre.find_genre(genre_name)
    genre_html = get_genres.css("li > h3").detect do |genre|
      title = genre.css("a").attribute("title").value
      title == genre_name
    end
    extension = genre_html.css("a").attribute("href").value

    "http://www.bookdaily.com#{extension}?perpage=60"
  end

  def self.get_random_book_page(genre_name)
    # from the genre page with many books, get a random book page
    extension = Nokogiri::HTML(open(get_genre_page(genre_name))).css("div#nodeGrid article:nth-child(#{rand(60)}) a").attribute("href").value
    "http://www.bookdaily.com#{extension}"
  end
  
  def self.get_random_book(genre_name)
    book_info = Nokogiri::HTML(open(get_random_book_page(genre_name))).css("section.book")

    title = book_info.css("section.book-intro h1.booktitle").text
    author = book_info.css("p:nth-child(2) a").text
    genre = self.genre

    text = ""
    i = 0
      
    # adds a paragraph at a time to the text string until it is longer than 1000 characters
    until text.length > 1000
      i += 1
      text << book_info.css("article.book-details p:nth-child(#{i})").text
    end

    BookBytes::Book.create_new_book(title, author, genre, text)
  end
end
