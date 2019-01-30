# require "book_bytes/version"

require 'rubygems'
require 'nokogiri'
require 'open-uri'

module BookBytes
  require_relative "./book_bytes/cli"
  require_relative "./book_bytes/book"
  require_relative "./book_bytes/genre"
  require_relative "./book_bytes/scraper"
end
