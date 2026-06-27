require 'json'

class Book
  # attr_accessor is Ruby's built-in macro that generates getter and setter
  # methods for each field - no explicit def needed, unlike C#'s typed properties
  attr_accessor :title, :author, :genre, :year

  def initialize(title, author, genre, year)
    @title = title
    @author = author
    @genre = genre
    @year  = year
  end

  # to_s is called automatically whenever a Book appears in string interpolation
  def to_s
    "\"#{@title}\" by #{@author} (#{@genre}, #{@year})"
  end

  # Serialize to a plain Hash with string keys so JSON round-trips cleanly
  def to_h
    { 'title' => @title, 'author' => @author, 'genre' => @genre, 'year' => @year }
  end

  # Class-level factory method; hash comes from JSON.parse which returns string keys
  def self.from_h(hash)
    new(hash['title'], hash['author'], hash['genre'], hash['year'])
  end
end
