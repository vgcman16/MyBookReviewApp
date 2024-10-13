import SwiftUI

struct BookListView: View {
    @EnvironmentObject var firestoreService: FirestoreService
    @EnvironmentObject var authService: AuthenticationService
    @State private var books: [Book] = []
    @State private var showingAddBook = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredBooks) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        BookRowView(book: book)
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Book Reviews")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddBook = true }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView { newBook in
                    if let userId = authService.user?.uid {
                        firestoreService.addBook(newBook, userId: userId) { result in
                            switch result {
                            case .success:
                                loadBooks()
                            case .failure(let error):
                                print("Error adding book: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search books")
        }
        .onAppear(perform: loadBooks)
    }
    
    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return books
        } else {
            return books.filter { $0.title.lowercased().contains(searchText.lowercased()) || $0.author.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func loadBooks() {
        if let userId = authService.user?.uid {
            firestoreService.getBooks(userId: userId) { result in
                switch result {
                case .success(let fetchedBooks):
                    books = fetchedBooks
                case .failure(let error):
                    print("Error fetching books: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        if let userId = authService.user?.uid {
            offsets.forEach { index in
                let book = books[index]
                if let bookId = book.id {
                    firestoreService.deleteBook(bookId: bookId, userId: userId) { result in
                        switch result {
                        case .success:
                            loadBooks()
                        case .failure(let error):
                            print("Error deleting book: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}

struct BookRowView: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(.headline)
            Text(book.author)
                .font(.subheadline)
            HStack {
                Text("Rating: \(book.rating)/5")
                    .font(.caption)
                Spacer()
                ForEach(book.categories, id: \.self) { category in
                    Text(category)
                        .font(.caption)
                        .padding(4)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(4)
                }
            }
        }
    }
}