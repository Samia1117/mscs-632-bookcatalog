require_relative 'book'
require_relative 'catalog'

catalog = BookCatalog.new

def display_books(books)
  if books.empty?
    puts 'No books found.'
  else
    books.each_with_index { |b, i| puts "  #{i + 1}. #{b}" }
  end
end

def display_grouped(grouped)
  if grouped.empty?
    puts 'No books in catalog.'
  else
    # sort_by returns a new array sorted by the block's return value
    grouped.sort_by { |key, _| key }.each do |key, books|
      puts "\n#{key} (#{books.size} book#{books.size == 1 ? '' : 's'}):"
      books.each { |b| puts "  - #{b}" }
    end
  end
end

# loop do runs indefinitely; break exits it
loop do
  puts "\n=== Book Catalog ==="
  puts '1. Add book'
  puts '2. Remove book'
  puts '3. Edit book'
  puts '4. Search by title'
  puts '5. Search by author'
  puts '6. Search by genre'
  puts '7. View all books'
  puts '8. Report by genre'
  puts '9. Report by author'
  puts '10. Exit'
  print 'Enter choice: '

  # case/when is Ruby's switch equivalent; it matches against === by default
  case gets.chomp
  when '1'
    print 'Title:  '; title  = gets.chomp
    print 'Author: '; author = gets.chomp
    print 'Genre:  '; genre  = gets.chomp
    print 'Year:   '
    begin
      # Integer() is stricter than .to_i - it raises ArgumentError on invalid input
      year = Integer(gets.chomp)
    rescue ArgumentError
      puts 'Invalid year - please enter a number.'
      next
    end
    catalog.add(title, author, genre, year)
    puts "Added: \"#{title}\""

  when '2'
    print 'Title to remove: '
    title = gets.chomp
    if catalog.remove(title)
      puts "Removed \"#{title}\"."
    else
      puts "No book found with title \"#{title}\"."
    end

  when '3'
    print 'Title of book to edit: '
    title = gets.chomp
    book  = catalog.find_by_title(title)

    if book.nil?
      puts "No book found with title \"#{title}\"."
    else
      puts "Editing: #{book}"
      updates = {}

      print "New title  (Enter to keep '#{book.title}'): "
      val = gets.chomp
      updates[:title] = val unless val.empty?

      print "New author (Enter to keep '#{book.author}'): "
      val = gets.chomp
      updates[:author] = val unless val.empty?

      print "New genre  (Enter to keep '#{book.genre}'): "
      val = gets.chomp
      updates[:genre] = val unless val.empty?

      print "New year   (Enter to keep '#{book.year}'): "
      val = gets.chomp
      unless val.empty?
        begin
          updates[:year] = Integer(val)
        rescue ArgumentError
          puts "Invalid year - keeping #{book.year}."
        end
      end

      if updates.empty?
        puts 'No changes made.'
      else
        # book is the same object in @books, so it reflects updates immediately
        catalog.edit(title, updates)
        puts "Updated: #{book}"
      end
    end

  when '4'
    print 'Search title: '
    display_books(catalog.search_by_title(gets.chomp))

  when '5'
    print 'Search author: '
    display_books(catalog.search_by_author(gets.chomp))

  when '6'
    print 'Search genre: '
    display_books(catalog.search_by_genre(gets.chomp))

  when '7'
    display_books(catalog.all)

  when '8'
    display_grouped(catalog.report_by_genre)

  when '9'
    display_grouped(catalog.report_by_author)

  when '10'
    puts 'Goodbye!'
    break

  else
    puts 'Invalid choice. Enter 1-10.'
  end
end
