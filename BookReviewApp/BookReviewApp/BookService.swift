import Foundation

class BookService {
    static let shared = BookService()
    private init() {}
    
    func getRecommendations() -> [Book] {
        let readBooks = UserDefaults.standard.readingList
        let genres = extractGenres(from: readBooks)
        
        let allBooks = [
            Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald", rating: 4, review: "A classic novel about the American Dream", categories: ["Fiction", "Classic"]),
            Book(title: "To the Lighthouse", author: "Virginia Woolf", rating: 5, review: "A masterpiece of modernist literature", categories: ["Fiction", "Modernist"]),
            Book(title: "The Catcher in the Rye", author: "J.D. Salinger", rating: 4, review: "A coming-of-age story that has influenced generations", categories: ["Fiction", "Coming-of-age"]),
            Book(title: "1984", author: "George Orwell", rating: 5, review: "A dystopian novel that remains relevant today", categories: ["Fiction", "Dystopian"]),
            Book(title: "The Hobbit", author: "J.R.R. Tolkien", rating: 4, review: "A fantasy adventure that spawned a genre", categories: ["Fiction", "Fantasy"])
        ]
        
        return allBooks.filter { book in
            !readBooks.contains { $0.id == book.id } &&
            !Set(book.categories).isDisjoint(with: Set(genres))
        }
    }
    
    private func extractGenres(from books: [Book]) -> [String] {
        let genreSet = Set(books.flatMap { $0.categories })
        return Array(genreSet)
    }
    
    func searchBooks(query: String) -> [Book] {
        let allBooks = UserDefaults.standard.readingList + getRecommendations()
        return allBooks.filter { book in
            book.title.lowercased().contains(query.lowercased()) ||
            book.author.lowercased().contains(query.lowercased())
        }
    }
    
    func addBook(_ book: Book) {
        var readingList = UserDefaults.standard.readingList
        readingList.append(book)
        UserDefaults.standard.readingList = readingList
    }
    
    func updateBook(_ book: Book) {
        var readingList = UserDefaults.standard.readingList
        if let index = readingList.firstIndex(where: { $0.id == book.id }) {
            readingList[index] = book
            UserDefaults.standard.readingList = readingList
        }
    }
    
    func deleteBook(_ book: Book) {
        var readingList = UserDefaults.standard.readingList
        readingList.removeAll { $0.id == book.id }
        UserDefaults.standard.readingList = readingList
    }
    
    func fetchBookInfo(isbn: String, completion: @escaping (Book?) -> Void) {
        // In a real app, you would call an API to fetch book info
        // For this example, we'll just return some dummy data
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let dummyBook = Book(
                title: "Scanned Book Title",
                author: "Scanned Book Author",
                rating: 0,
                review: "",
                categories: ["Fiction", "Mystery"],
                pageCount: 300
            )
            completion(dummyBook)
        }
    }
}