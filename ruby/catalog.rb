require 'json'
require_relative 'book'

class BookCatalog
  def initialize(file = 'catalog.json')
    @file  = file
    @books = []
    load_from_file
  end

  def add(title, author, genre, year)
    @books << Book.new(title, author, genre, year)
    save_to_file
  end

  def remove(title)
    before = @books.size
    # delete_if iterates with a block and removes any element where the block is true
    @books.delete_if { |b| b.title.downcase == title.downcase }
    @books.size < before ? save_to_file : false
  end

  # find returns the first element for which the block is true, or nil
  def find_by_title(title)
    @books.find { |b| b.title.downcase == title.downcase }
  end

  # updates is a hash of only the fields to change; omitted fields are left as-is
  def edit(title, updates)
    book = find_by_title(title)
    return nil unless book

    book.title  = updates[:title]          if updates[:title]
    book.author = updates[:author]         if updates[:author]
    book.genre  = updates[:genre]          if updates[:genre]
    book.year   = updates[:year]           if updates[:year]
    save_to_file
    book
  end

  # select returns a new array of elements for which the block returns true
  def search_by_title(query)
    @books.select { |b| b.title.downcase.include?(query.downcase) }
  end

  def search_by_author(query)
    @books.select { |b| b.author.downcase.include?(query.downcase) }
  end

  def search_by_genre(query)
    @books.select { |b| b.genre.downcase.include?(query.downcase) }
  end

  def all
    @books
  end

  # group_by is an Enumerable method that groups elements by the block's return value
  # &:genre is shorthand for { |b| b.genre } using Symbol#to_proc
  def report_by_genre
    @books.group_by(&:genre)
  end

  def report_by_author
    @books.group_by(&:author)
  end

  private

  def save_to_file
    File.write(@file, JSON.pretty_generate(@books.map(&:to_h)))
  end

  def load_from_file
    return unless File.exist?(@file)
    # begin/rescue is Ruby's equivalent of try/catch
    begin
      data   = JSON.parse(File.read(@file))
      @books = data.map { |h| Book.from_h(h) }
    rescue JSON::ParserError
      @books = []
    end
  end
end
