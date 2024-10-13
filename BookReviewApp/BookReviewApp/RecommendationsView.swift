import SwiftUI

struct RecommendationsView: View {
    @State private var recommendations: [Book] = []
    
    var body: some View {
        NavigationView {
            List(recommendations) { book in
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author)
                        .font(.subheadline)
                    Text("Rating: \(book.rating)/5")
                        .font(.caption)
                    Button("Add to Reading List") {
                        addToReadingList(book)
                    }
                }
            }
            .navigationTitle("Recommended Books")
        }
        .onAppear(perform: loadRecommendations)
    }
    
    func loadRecommendations() {
        recommendations = BookService.shared.getRecommendations()
    }
    
    func addToReadingList(_ book: Book) {
        var readingList = UserDefaults.standard.readingList
        readingList.append(book)
        UserDefaults.standard.readingList = readingList
    }
}

struct RecommendationsView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationsView()
    }
}