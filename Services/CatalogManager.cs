using BookCatalogCS.Models;

namespace BookCatalogCS.Services;

public class CatalogManager
{
    // Handles reading from and writing to the JSON file.
    private readonly JsonStorage storage = new();

    // Stores all books currently loaded into memory.
    private List<Book> books;

    // Load existing books from the JSON file when the application starts.
    public CatalogManager()
    {
        books = storage.LoadBooks();
    }
    public Book? FindBook(string title)
{
    return books.FirstOrDefault(b =>
        b.Title.Equals(title, StringComparison.OrdinalIgnoreCase));
}

    public bool AddBook(Book book)
    {
        // Prevent duplicate books with the same title and author.
        bool exists = books.Any(b =>
            b.Title.Equals(book.Title, StringComparison.OrdinalIgnoreCase) &&
            b.Author.Equals(book.Author, StringComparison.OrdinalIgnoreCase));

        if (exists)
            return false;

        books.Add(book);

        // Save the updated catalog to the JSON file.
        storage.SaveBooks(books);

        return true;
    }

    public bool EditBook(string oldTitle, Book updatedBook)
    {
        // Find the book by its title.
        var existingBook = books.FirstOrDefault(b =>
            b.Title.Equals(oldTitle, StringComparison.OrdinalIgnoreCase));

        if (existingBook == null)
            return false;

        // Replace the existing values with the updated information.
        existingBook.Title = updatedBook.Title;
        existingBook.Author = updatedBook.Author;
        existingBook.Genre = updatedBook.Genre;
        existingBook.PublicationYear = updatedBook.PublicationYear;

        // Save the changes to the JSON file.
        storage.SaveBooks(books);

        return true;
    }

    public bool RemoveBook(string title)
    {
        // Search for the book by title (case-insensitive).
        var book = books.FirstOrDefault(b =>
            b.Title.Equals(title, StringComparison.OrdinalIgnoreCase));

        if (book == null)
            return false;

        books.Remove(book);

        // Save the updated catalog.
        storage.SaveBooks(books);

        return true;
    }

    // Returns books whose title, author, or genre matches the search keyword.
    public List<Book> SearchBooks(string keyword)
    {
        return books.Where(b =>
            b.Title.Contains(keyword, StringComparison.OrdinalIgnoreCase) ||
            b.Author.Contains(keyword, StringComparison.OrdinalIgnoreCase) ||
            b.Genre.Contains(keyword, StringComparison.OrdinalIgnoreCase))
            .ToList();
    }

    // Returns all books currently stored in the catalog.
    public List<Book> GetAllBooks()
    {
        return books;
    }

}