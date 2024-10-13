import SwiftUI

struct ReadingListView: View {
    @State private var readingList: [Book] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(readingList) { book in
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: removeFromReadingList)
            }
            .navigationTitle("Reading List")
        }
        .onAppear(perform: loadReadingList)
    }
    
    func loadReadingList() {
        // In a real app, this would load from UserDefaults or a database
        readingList = UserDefaults.standard.readingList
    }
    
    func removeFromReadingList(at offsets: IndexSet) {
        readingList.remove(atOffsets: offsets)
        UserDefaults.standard.readingList = readingList
    }
}

struct ReadingListView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingListView()
    }
}