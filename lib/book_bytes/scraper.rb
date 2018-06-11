require 'pry'

class BookBytes::Scraper
  attr_accessor :genre

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
  
  def self.get_book_page
    extension = Nokogiri::HTML(open(get_genre_page("Humor & Entertainment"))).css("div#nodeGrid article:nth-child(#{rand(60)}) a").attribute("href").value
    "http://www.bookdaily.com#{extension}"
  end

  def self.get_book_details
    # get_genre_hash.each do |genre, url|
    #   i = 1
    #   Nokogiri::HTML(open("http://www.bookdaily.com/#{url}?perpage=30")).css("#nodeGrid article:nth-child(${i}) a").attribute("href").value

      book_info = Nokogiri::HTML(open(get_book_page)).css("section.book")

      title = book_info.css("section.book-intro h1.booktitle").text
      author = book_info.css("p:nth-child(2) a").text
  # puts title
  # puts author
      # puts "http://www.bookdaily.com/#{book_link}"

    text = ""
    i = 0
      
    until text.length > 1000
      i += 1
      text << book_info.css("article.book-details p:nth-child(#{i})").text
    end

    book_obj = {title: title, author: author, text: text, genre: @genre}
    puts book_obj
  end
end
