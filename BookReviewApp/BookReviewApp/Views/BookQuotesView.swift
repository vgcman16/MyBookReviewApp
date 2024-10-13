import SwiftUI

struct BookQuotesView: View {
    @StateObject private var quoteService = BookQuoteService()
    @State private var showingAddQuote = false
    @State private var newQuoteText = ""
    @State private var newQuoteBook = ""
    @State private var newQuoteAuthor = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(quoteService.quotes) { quote in
                    VStack(alignment: .leading) {
                        Text(quote.text)
                            .font(.body)
                            .italic()
                        Text("- \(quote.author), \(quote.book)")
                            .font(.caption)
                    }
                }
                .onDelete(perform: quoteService.removeQuote)
            }
            .navigationTitle("Book Quotes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddQuote = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddQuote) {
                AddQuoteView(quoteService: quoteService)
            }
        }
    }
}

struct AddQuoteView: View {
    @ObservedObject var quoteService: BookQuoteService
    @Environment(\.presentationMode) var presentationMode
    
    @State private var quoteText = ""
    @State private var book = ""
    @State private var author = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Quote", text: $quoteText)
                TextField("Book", text: $book)
                TextField("Author", text: $author)
            }
            .navigationTitle("Add Quote")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newQuote = BookQuote(text: quoteText, book: book, author: author, date: Date())
                        quoteService.addQuote(newQuote)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}