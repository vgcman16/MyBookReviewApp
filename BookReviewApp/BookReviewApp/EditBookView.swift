import SwiftUI

struct EditBookView: View {
    @Binding var book: Book
    var onSave: (Book) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String
    @State private var author: String
    @State private var rating: Int
    @State private var review: String
    @State private var categories: [String]
    @State private var newCategory = ""
    
    init(book: Binding<Book>, onSave: @escaping (Book) -> Void) {
        self._book = book
        self.onSave = onSave
        _title = State(initialValue: book.wrappedValue.title)
        _author = State(initialValue: book.wrappedValue.author)
        _rating = State(initialValue: book.wrappedValue.rating)
        _review = State(initialValue: book.wrappedValue.review)
        _categories = State(initialValue: book.wrappedValue.categories)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                Picker("Rating", selection: $rating) {
                    ForEach(1..<6) { rating in
                        Text("\(rating)").tag(rating)
                    }
                }
                TextEditor(text: $review)
                    .frame(height: 200)
                
                Section(header: Text("Categories")) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                    .onDelete(perform: deleteCategory)
                    
                    HStack {
                        TextField("Add category", text: $newCategory)
                        Button(action: addCategory) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
            }
            .navigationTitle("Edit Book")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let updatedBook = Book(id: book.id, title: title, author: author, rating: rating, review: review, categories: categories)
                        onSave(updatedBook)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    func addCategory() {
        if !newCategory.isEmpty {
            categories.append(newCategory)
            newCategory = ""
        }
    }
    
    func deleteCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
    }
}

struct EditBookView_Previews: PreviewProvider {
    static var previews: some View {
        EditBookView(book: .constant(Book(title: "Sample Book", author: "Sample Author", rating: 4, review: "This is a sample review."))) { _ in }
    }
}