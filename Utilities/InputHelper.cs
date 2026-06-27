namespace BookCatalogCS.Utilities;

public static class InputHelper
{
    public static string GetRequiredInput(string prompt)
    {
        while (true)
        {
            Console.Write(prompt);
            string? input = Console.ReadLine();

            if (!string.IsNullOrWhiteSpace(input))
                return input.Trim();

            Console.WriteLine("Input cannot be empty. Please try again.");
        }
    }

    public static int GetPublicationYear()
    {
        while (true)
        {
            Console.Write("Publication Year: ");
            string? input = Console.ReadLine();

            if (int.TryParse(input, out int year) &&
                year > 0 &&
                year <= DateTime.Now.Year)
            {
                return year;
            }

            Console.WriteLine($"Please enter a valid year. Example: {DateTime.Now.Year}.");
        }
    }

    public static string GetOptionalInput(string prompt, string currentValue)
{
    Console.Write($"{prompt} [{currentValue}]: ");

    string? input = Console.ReadLine();

    return string.IsNullOrWhiteSpace(input)
        ? currentValue
        : input.Trim();
}

public static int GetOptionalPublicationYear(int currentYear)
{
    while (true)
    {
        Console.Write($"Publication Year [{currentYear}]: ");

        string? input = Console.ReadLine();

        if (string.IsNullOrWhiteSpace(input))
            return currentYear;

        if (int.TryParse(input, out int year) &&
            year > 0 &&
            year <= DateTime.Now.Year)
        {
            return year;
        }

        Console.WriteLine($"Please enter a valid year between 1 and {DateTime.Now.Year}, or press Enter to keep the current year.");
    }
}  }