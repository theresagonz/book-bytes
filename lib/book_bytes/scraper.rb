require 'pry'

class BookBytes::Scraper

  def self.get_genres
    Nokogiri::HTML(open("http://www.bookdaily.com/browse")).css("section.genre-categories")
  end

  def self.get_art_link
    appendage = get_genres.css("li > h3 a[title~=Arts]").attribute("href").value
    "http://www.bookdaily.com/#{appendage}?perpage=30&display=list"
  end

  def self.get_art_book
    book = Nokogiri::HTML(open(get_art_link)).css("#nodeList article:nth-child(2) a").attribute("href").value

    "http://www.bookdaily.com/#{book}"
  end

  def self.get_book_details
    book_info = Nokogiri::HTML(open(get_art_book)).css("section.book")

    title = book_info.css("section.book-intro h1.booktitle").text
    author = book_info.css("p:nth-child(2) a").text

    text = ""
    i = 0
      
    until text.length > 1000
      i += 1
      text << book_info.css("article.book-details p:nth-child(#{i})").text
    end

    book_obj = {title: title, author: author, text: text, genre: BookBytes::Genre.find_genre("Art")}
    puts book_obj
  end
end
