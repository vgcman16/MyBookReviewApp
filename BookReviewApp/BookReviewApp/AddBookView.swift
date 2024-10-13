import SwiftUI

struct AddBookView: View {
    @Environment(\.presentationMode) var presentationMode
    var onSave: (Book) -> Void
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var review = ""
    @State private var categories: [String] = []
    @State private var newCategory = ""
    
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
            .navigationTitle("Add Book")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, rating: rating, review: review, categories: categories)
                        onSave(newBook)
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