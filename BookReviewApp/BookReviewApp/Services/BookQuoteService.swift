import Foundation

class BookQuoteService: ObservableObject {
    @Published var quotes: [BookQuote] = []
    
    init() {
        loadQuotes()
    }
    
    func loadQuotes() {
        if let data = UserDefaults.standard.data(forKey: "bookQuotes"),
           let savedQuotes = try? JSONDecoder().decode([BookQuote].self, from: data) {
            quotes = savedQuotes
        }
    }
    
    func addQuote(_ quote: BookQuote) {
        quotes.append(quote)
        saveQuotes()
    }
    
    func removeQuote(at offsets: IndexSet) {
        quotes.remove(atOffsets: offsets)
        saveQuotes()
    }
    
    private func saveQuotes() {
        if let encodedData = try? JSONEncoder().encode(quotes) {
            UserDefaults.standard.set(encodedData, forKey: "bookQuotes")
        }
    }
}