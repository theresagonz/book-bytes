require 'pry'

class BookBytes::Scraper
  attr_accessor :genres
  @genres = {}

  def self.get_genres
    Nokogiri::HTML(open("http://www.bookdaily.com/browse")).css("section.genre-categories")
  end

  def self.genres
    @genres
  end

  def self.get_genre_hash
    appendage = get_genres.css("li > h3").each do |genre|
      title = genre.css("a").attribute("title").value
      
      case
      when title.include?("Arts")
        genres[:arts] = genre.css("a").attribute("href").value
      when title.include?("Biographies") && !title.include?("Teen") && !title.include?("Business")
        genres[:biographies] = genre.css("a").attribute("href").value
      when title.include?("Cooking")
        genres[:cooking] = genre.css("a").attribute("href").value
      when title.include?("History") && !title.include?("Teen")
        genres[:history] = genre.css("a").attribute("href").value
      when title.include?("Humor")
        genres[:humor] = genre.css("a").attribute("href").value
      when title.include?("Literature") && !title.include?("Teen")
        genres[:literary] = genre.css("a").attribute("href").value
      when title.include?("Mystery")
        genres[:mystery] = genre.css("a").attribute("href").value
      when title.include?("Outdoors & Nature") 
        genres[:outdoors] = genre.css("a").attribute("href").value
      when title.include?("Romance") && !title.include?("Teen")
        genres[:romance] = genre.css("a").attribute("href").value
      when title.include?("Science Fiction & Fantasy") && !title.include?("Teen")
        genres[:scifi] = genre.css("a").attribute("href").value
      when title.include?("Self-Help")
        genres[:selfhelp] = genre.css("a").attribute("href").value
      when title == "Science"
        genres[:science] = genre.css("a").attribute("href").value
      when title.include?("Social Sciences")
        genres[:social] = genre.css("a").attribute("href").value
      when title.include?("Sports") && !title.include?("Youth") && !title.include?("Teen")
        genres[:sports] = genre.css("a").attribute("href").value
      when title.include?("Travel") && !title.include?("Specialty")
        genres[:travel] = genre.css("a").attribute("href").value
      end
      # puts genres
    end

      # puts appendage
      
      # a[title~=
      #   Art"
    #   .attribute("href").value
    # "http://www.bookdaily.com/#{appendage}?perpage=30&display=list"
  end

  def self.get_art_book
    book = Nokogiri::HTML(open(get_art_link)).css("#nodeList article:nth-child(3) a").attribute("href").value

    "http://www.bookdaily.com/#{book}"
  end

  def self.get_book_details
    book_info = Nokogiri::HTML(open(get_art_book)).css("section.book")

    title = book_info.css("section.book-intro h1.booktitle").text
    author = book_info.css("p:nth-child(3) a").text

    text = ""
    i = 0
      
    until text.length > 1000
      i += 1
      text << book_info.css("article.book-details p:nth-child(#{i})").text
    end

    book_obj = {title: title, author: author, text: text, genre: BookBytes::Genre.find_genre("Science")}
    puts book_obj
  end
end
