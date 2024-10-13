import SwiftUI

struct BookDetailView: View {
    @EnvironmentObject var firestoreService: FirestoreService
    @EnvironmentObject var authService: AuthenticationService
    @State var book: Book
    @State private var isEditing = false
    @State private var editedBook: Book
    @State private var showingDeleteAlert = false
    
    init(book: Book) {
        self._book = State(initialValue: book)
        self._editedBook = State(initialValue: book)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(book.title)
                    .font(.title)
                Text("by \(book.author)")
                    .font(.subheadline)
                HStack {
                    Text("Rating: \(book.rating)/5")
                        .font(.headline)
                    Spacer()
                    ForEach(book.categories, id: \.self) { category in
                        Text(category)
                            .font(.caption)
                            .padding(4)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(4)
                    }
                }
                Text("Review:")
                    .font(.headline)
                Text(book.review)
                    .font(.body)
                
                Button(action: {
                    isEditing = true
                }) {
                    Text("Edit Book")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button(action: {
                    showingDeleteAlert = true
                }) {
                    Text("Delete Book")
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle("Book Details")
        .sheet(isPresented: $isEditing) {
            EditBookView(book: $editedBook, onSave: { updatedBook in
                if let userId = authService.user?.uid {
                    firestoreService.updateBook(updatedBook, userId: userId) { result in
                        switch result {
                        case .success:
                            book = updatedBook
                        case .failure(let error):
                            print("Error updating book: \(error.localizedDescription)")
                        }
                    }
                }
            })
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Delete Book"),
                message: Text("Are you sure you want to delete this book?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let userId = authService.user?.uid, let bookId = book.id {
                        firestoreService.deleteBook(bookId: bookId, userId: userId) { result in
                            switch result {
                            case .success:
                                // Navigate back to the book list
                                // You might need to use a custom navigation solution or a binding to handle this
                            case .failure(let error):
                                print("Error deleting book: \(error.localizedDescription)")
                            }
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}