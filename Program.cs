using BookCatalogCS.Models;
using BookCatalogCS.Services;
using BookCatalogCS.Utilities;

CatalogManager catalog = new();

bool running = true;

while (running)
{
    Console.WriteLine("\n===== BOOK CATALOG =====");
    Console.WriteLine("\nMenu Options:");
    Console.WriteLine("1. Add Book");
    Console.WriteLine("2. Edit Book");
    Console.WriteLine("3. Remove Book");
    Console.WriteLine("4. Search Books");
    Console.WriteLine("5. View All Books");
    Console.WriteLine("6. Report by Genre");
    Console.WriteLine("7. Report by Author");
    Console.WriteLine("8. Exit");
    Console.WriteLine("\n========================");

    Console.Write("Choose an option from the menu (1-8): ");

    switch (Console.ReadLine())
    {
        case "1":
            try
            {
                string title = InputHelper.GetRequiredInput("Title: ");
                string author = InputHelper.GetRequiredInput("Author: ");
                string genre = InputHelper.GetRequiredInput("Genre: ");
                int year = InputHelper.GetPublicationYear();

                bool bookAdded = catalog.AddBook(new Book(title, author, genre, year));

                  Console.WriteLine("\n");
                Console.WriteLine(bookAdded
                    ? "Book added successfully."
                    : "Book already exists in the catalog.");
            }
            catch
            {
                Console.WriteLine("An unexpected error occurred while adding the book.");
            }
            break;

       case "2":
            try
            {
                  string oldTitle = InputHelper.GetRequiredInput("Enter the title of the book to edit: ");

                  Book? existingBook = catalog.FindBook(oldTitle);

                  if (existingBook == null)
                  {
                        Console.WriteLine("\n");
                        Console.WriteLine("Book not found.");
                        break;
                  }
                  Console.WriteLine("\n");
                  Console.WriteLine("\nCurrent Book Details:");
                  Console.WriteLine(existingBook);

                  Console.WriteLine("\nPress Enter to keep the current value.");

                  string newTitle = InputHelper.GetOptionalInput("New Title", existingBook.Title);
                  string newAuthor = InputHelper.GetOptionalInput("New Author", existingBook.Author);
                  string newGenre = InputHelper.GetOptionalInput("New Genre", existingBook.Genre);
                  int newYear = InputHelper.GetOptionalPublicationYear(existingBook.PublicationYear);

                  bool edited = catalog.EditBook(
                        oldTitle,
                        new Book(newTitle, newAuthor, newGenre, newYear)
                  );
                  Console.WriteLine("\n");

                  Console.WriteLine(edited
                        ? "Book updated successfully."
                        : "Book could not be updated.");
            }
            catch
            {
                  Console.WriteLine("An unexpected error occurred while editing the book.");
            }
            break;

        case "3":
            try
            {
                string bookTitle = InputHelper.GetRequiredInput("Enter the title of the book to remove: ");

                bool removed = catalog.RemoveBook(bookTitle);
                   Console.WriteLine("\n");
                Console.WriteLine(removed
                    ? "Book removed successfully."
                    : "Book not found.");
            }
            catch
            {
                Console.WriteLine("An unexpected error occurred while removing the book.");
            }
            break;

        case "4":
            try
            {
                var results = catalog.SearchBooks(
                    InputHelper.GetRequiredInput("Enter title, author, or genre to search: ")
                );

                if (results.Count == 0)
                    Console.WriteLine("No books found.");
                else
                    results.ForEach(Console.WriteLine);
            }
            catch
            {
                Console.WriteLine("An unexpected error occurred while searching books.");
            }
            break;

        case "5":
            try
            {
                var books = catalog.GetAllBooks();

                if (books.Count == 0)
                    Console.WriteLine("No books in catalog.");
                else
                    books.ForEach(Console.WriteLine);
            }
            catch
            {
                Console.WriteLine("An unexpected error occurred while displaying books.");
            }
            break;

        case "6":
            try
            {
                   Console.WriteLine("\n");
                Console.WriteLine("Book Catalog Report by Genre:");
                ReportManager.ReportByGenre(catalog.GetAllBooks());
            }
            catch
            {
                Console.WriteLine("An unexpected error occurred while generating the genre report.");
            }
            break;

        case "7":
            try
            {
                   Console.WriteLine("\n");
                Console.WriteLine("Book Catalog Report by Author:");
                ReportManager.ReportByAuthor(catalog.GetAllBooks());
            }
            catch
            {
                Console.WriteLine("An unexpected error occurred while generating the author report.");
            }
            break;

        case "8":
            running = false;
             Console.WriteLine("\n");
            Console.WriteLine("Goodbye!");
            break;

        default:
            Console.WriteLine("Invalid option. Please choose a number from 1 to 8.");
            break;
    }

    if (running)
    {
        Console.WriteLine("\nPress any key to continue...");
        Console.ReadKey();
        Console.Clear();
    }
}