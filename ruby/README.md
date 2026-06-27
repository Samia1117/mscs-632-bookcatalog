# Book Catalog — Ruby

A command-line application for managing a personal book catalog. Add, search, edit, and report on your book collection — all stored locally in a JSON file so your data persists between sessions.

---

## Features

- **Add books** — store a title, author, genre, and publication year
- **Remove books** — delete a book by title
- **Edit books** — update any field without re-entering everything
- **Search** — find books by title, author, or genre (case-insensitive)
- **View all** — list every book in the catalog
- **Reports** — view books grouped by genre or author with counts
- **Persistent storage** — catalog is automatically saved to `catalog.json` after every change

---

## Requirements

- Ruby 2.6 or higher (no external gems needed — only standard library)

Check your version with:

```bash
ruby --version
```

---

## Running the App

From the `ruby/` directory:

```bash
ruby main.rb
```

You'll see a numbered menu. Type a number and press Enter to navigate.

```
=== Book Catalog ===
1. Add book
2. Remove book
3. Edit book
4. Search by title
5. Search by author
6. Search by genre
7. View all books
8. Report by genre
9. Report by author
10. Exit
Enter choice:
```

When editing, just press **Enter** on any field you want to leave unchanged.

---

## Running the Tests

```bash
ruby test_catalog.rb
```

The test suite covers all core operations — add, remove, edit, search, reports, and JSON persistence. Tests use a temporary file and clean up after themselves, so they won't touch your real `catalog.json`.

---

## Data Storage

Books are saved to `catalog.json` in the same directory you run the app from. The file is human-readable:

```json
[
  {
    "title": "Siddhartha",
    "author": "Hermann Hesse",
    "genre": "Philosophical Fiction",
    "year": 1922
  }
]
```

You can back it up, move it, or share it freely — just keep it next to `main.rb` when running the app.

---

## Project Structure

```
ruby/
├── book.rb          # Book class (data model)
├── catalog.rb       # BookCatalog class (all operations + file I/O)
├── main.rb          # CLI menu and user interaction
├── test_catalog.rb  # Minitest test suite
└── catalog.json     # Auto-generated on first add
```
