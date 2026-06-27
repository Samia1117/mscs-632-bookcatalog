
# Book Catalog Application (C#)
## Project Structure

```text
csharp/
│
├── Data/
│   └── books.json
│
├── Models/
│   └── Book.cs
│
├── Services/
│   ├── CatalogManager.cs
│   ├── JsonStorage.cs
│   └── ReportManager.cs
│
├── Utilities/
│   └── InputHelper.cs
│
├── Program.cs
├── BookCatalogCS.csproj
└── .gitignore
```

---

## Technologies Used

- C#
- .NET
- JSON Serialization (`System.Text.Json`)
- LINQ
- Object-Oriented Programming

---

## Running the Application

### Prerequisites

- .NET SDK 10.0 (or compatible version)
- Visual Studio Code or Visual Studio

### Clone the repository

```bash
git clone https://github.com/Samia1117/mscs-632-bookcatalog.git
```

Navigate to the C# project:

```bash
cd mscs-632-bookcatalog/csharp
```

Run the application:

```bash
dotnet run
```

---

## Menu Options

```text
1. Add Book
2. Edit Book
3. Remove Book
4. Search Books
5. View All Books
6. Report by Genre
7. Report by Author
8. Exit
```

---

## Input Validation

The application validates user input by:

- Preventing empty Title, Author, and Genre fields.
- Ensuring the Publication Year is numeric.
- Rejecting future publication years.
- Preventing duplicate books with the same title and author.

---

## Exception Handling

Major application operations are enclosed within `try-catch` blocks to gracefully handle unexpected runtime errors without terminating the application.

---

## Persistent Storage

Books are stored in:

```text
Data/books.json
```

The file is automatically updated whenever a book is added, edited, or removed.

---
