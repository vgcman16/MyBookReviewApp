import SwiftUI

struct BookDetailView: View {
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
                
                Button(action: {
                    SocialSharingService.shareBook(book)
                }) {
                    Text("Share")
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle("Book Details")
        .sheet(isPresented: $isEditing) {
            EditBookView(book: $editedBook, onSave: { updatedBook in
                book = updatedBook
                BookService.shared.updateBook(updatedBook)
            })
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Delete Book"),
                message: Text("Are you sure you want to delete this book?"),
                primaryButton: .destructive(Text("Delete")) {
                    BookService.shared.deleteBook(book)
                    // Navigate back to the book list
                },
                secondaryButton: .cancel()
            )
        }
    }
}