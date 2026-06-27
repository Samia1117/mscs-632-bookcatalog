using System.Text.Json;
using BookCatalogCS.Models;

namespace BookCatalogCS.Services;

public class JsonStorage
{
    private readonly string filePath =
        Path.Combine(Directory.GetCurrentDirectory(), "Data", "books.json");

    public List<Book> LoadBooks()
    {
        try
        {
            if (!File.Exists(filePath))
            {
                Directory.CreateDirectory(Path.GetDirectoryName(filePath)!);
                File.WriteAllText(filePath, "[]");
                return new List<Book>();
            }

            string json = File.ReadAllText(filePath);

            if (string.IsNullOrWhiteSpace(json))
                return new List<Book>();

            return JsonSerializer.Deserialize<List<Book>>(json)
                   ?? new List<Book>();
        }
        catch (JsonException)
        {
            Console.WriteLine("Error: The books.json file contains invalid JSON.");
            return new List<Book>();
        }
        catch (IOException)
        {
            Console.WriteLine("Error: Unable to read the books.json file.");
            return new List<Book>();
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Unexpected error while loading books: {ex.Message}");
            return new List<Book>();
        }
    }

    public void SaveBooks(List<Book> books)
    {
        try
        {
            Directory.CreateDirectory(Path.GetDirectoryName(filePath)!);

            var options = new JsonSerializerOptions
            {
                WriteIndented = true
            };

            string json = JsonSerializer.Serialize(books, options);
            File.WriteAllText(filePath, json);
        }
        catch (IOException)
        {
            Console.WriteLine("Error: Unable to save books to the JSON file.");
        }
        catch (UnauthorizedAccessException)
        {
            Console.WriteLine("Error: Permission denied while saving books.");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Unexpected error while saving books: {ex.Message}");
        }
    }
}