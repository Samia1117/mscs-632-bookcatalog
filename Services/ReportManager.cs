using BookCatalogCS.Models;

namespace BookCatalogCS.Services;

public class ReportManager
{
    public static void ReportByGenre(List<Book> books)
    {
        var groups = books.GroupBy(b => b.Genre);

        foreach (var group in groups)
        {
            Console.WriteLine($"\nGenre: {group.Key}");

            foreach (var book in group)
            {
                Console.WriteLine(book);
            }
        }
    }

    public static void ReportByAuthor(List<Book> books)
    {
        var groups = books.GroupBy(b => b.Author);

        foreach (var group in groups)
        {
            Console.WriteLine($"\nAuthor: {group.Key}");

            foreach (var book in group)
            {
                Console.WriteLine(book);
            }
        }
    }
}