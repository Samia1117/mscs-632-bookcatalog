require 'minitest/autorun'
require_relative 'book'
require_relative 'catalog'

class BookTest < Minitest::Test
  def test_to_s
    b = Book.new('Dune', 'Herbert', 'Sci-Fi', 1965)
    assert_equal '"Dune" by Herbert (Sci-Fi, 1965)', b.to_s
  end

  def test_to_h_and_from_h
    b = Book.new('Dune', 'Herbert', 'Sci-Fi', 1965)
    b2 = Book.from_h(b.to_h)
    assert_equal b.title, b2.title
    assert_equal b.year,  b2.year
  end
end

class BookCatalogTest < Minitest::Test
  TEST_FILE = 'test_catalog.json'

  def setup
    File.delete(TEST_FILE) if File.exist?(TEST_FILE)
    @cat = BookCatalog.new(TEST_FILE)
  end

  def teardown
    File.delete(TEST_FILE) if File.exist?(TEST_FILE)
  end

  def test_add_book
    @cat.add('The Hobbit', 'Tolkien', 'Fantasy', 1937)
    assert_equal 1, @cat.all.size
    assert_equal 'The Hobbit', @cat.all.first.title
  end

  def test_remove_existing_book
    @cat.add('The Hobbit', 'Tolkien', 'Fantasy', 1937)
    result = @cat.remove('The Hobbit')
    assert result, 'remove should return truthy when a book is deleted'
    assert_equal 0, @cat.all.size
  end

  def test_remove_missing_book
    result = @cat.remove('Nonexistent')
    assert_equal false, result
  end

  def test_remove_is_case_insensitive
    @cat.add('The Hobbit', 'Tolkien', 'Fantasy', 1937)
    @cat.remove('the hobbit')
    assert_equal 0, @cat.all.size
  end

  def test_search_by_title
    @cat.add('The Hobbit', 'Tolkien', 'Fantasy', 1937)
    @cat.add('Dune', 'Herbert', 'Sci-Fi', 1965)
    results = @cat.search_by_title('hobbit')
    assert_equal 1, results.size
    assert_equal 'The Hobbit', results.first.title
  end

  def test_search_by_author
    @cat.add('The Hobbit', 'Tolkien', 'Fantasy', 1937)
    @cat.add('Dune', 'Herbert', 'Sci-Fi', 1965)
    results = @cat.search_by_author('tolkien')
    assert_equal 1, results.size
  end

  def test_search_by_genre
    @cat.add('The Hobbit', 'Tolkien', 'Fantasy', 1937)
    @cat.add('1984', 'Orwell', 'Dystopian', 1949)
    assert_equal 1, @cat.search_by_genre('fantasy').size
    assert_equal 0, @cat.search_by_genre('mystery').size
  end

  def test_report_by_genre
    @cat.add('The Hobbit', 'Tolkien', 'Fantasy', 1937)
    @cat.add('LOTR', 'Tolkien', 'Fantasy', 1954)
    @cat.add('Dune', 'Herbert', 'Sci-Fi', 1965)
    grouped = @cat.report_by_genre
    assert_equal 2, grouped['Fantasy'].size
    assert_equal 1, grouped['Sci-Fi'].size
  end

  def test_report_by_author
    @cat.add('The Hobbit', 'Tolkien', 'Fantasy', 1937)
    @cat.add('LOTR', 'Tolkien', 'Fantasy', 1954)
    @cat.add('Dune', 'Herbert', 'Sci-Fi', 1965)
    grouped = @cat.report_by_author
    assert_equal 2, grouped['Tolkien'].size
    assert_equal 1, grouped['Herbert'].size
  end

  def test_persistence
    @cat.add('The Hobbit', 'Tolkien', 'Fantasy', 1937)
    # Load a fresh catalog from the same file - should see saved data
    cat2 = BookCatalog.new(TEST_FILE)
    assert_equal 1, cat2.all.size
    assert_equal 'The Hobbit', cat2.all.first.title
  end

  def test_json_file_is_valid
    @cat.add('Dune', 'Herbert', 'Sci-Fi', 1965)
    raw = File.read(TEST_FILE)
    parsed = JSON.parse(raw)
    assert_equal 1, parsed.size
    assert_equal 'Dune', parsed.first['title']
  end

  def test_edit_genre
    @cat.add('Siddhartha', 'Hesse', 'Philosophy', 1922)
    @cat.edit('Siddhartha', { genre: 'Philosophical Fiction' })
    assert_equal 'Philosophical Fiction', @cat.all.first.genre
  end

  def test_edit_multiple_fields
    @cat.add('Siddhartha', 'Hesse', 'Philosophy', 1922)
    @cat.edit('Siddhartha', { genre: 'Philosophical Fiction', year: 1923 })
    book = @cat.all.first
    assert_equal 'Philosophical Fiction', book.genre
    assert_equal 1923, book.year
  end

  def test_edit_persists_to_json
    @cat.add('Siddhartha', 'Hesse', 'Philosophy', 1922)
    @cat.edit('Siddhartha', { genre: 'Philosophical Fiction' })
    cat2 = BookCatalog.new(TEST_FILE)
    assert_equal 'Philosophical Fiction', cat2.all.first.genre
  end

  def test_edit_nonexistent_book_returns_nil
    result = @cat.edit('Ghost Book', { genre: 'Mystery' })
    assert_nil result
  end

  def test_find_by_title
    @cat.add('Dune', 'Herbert', 'Sci-Fi', 1965)
    assert_equal 'Dune', @cat.find_by_title('dune').title
    assert_nil @cat.find_by_title('missing')
  end
end
