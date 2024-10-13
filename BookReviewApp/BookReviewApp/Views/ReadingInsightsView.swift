import SwiftUI
import Charts

struct ReadingInsightsView: View {
    @State private var readingStats: ReadingStats?
    @State private var monthlyReadCount: [MonthlyReadCount] = []
    @State private var genreDistribution: [GenreCount] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let stats = readingStats {
                        InsightCard(title: "Books Read", value: "\(stats.booksRead)")
                        InsightCard(title: "Total Pages", value: "\(stats.totalPages)")
                        InsightCard(title: "Average Rating", value: String(format: "%.1f", stats.averageRating))
                        InsightCard(title: "Favorite Genre", value: stats.favoriteGenre)
                        
                        Text("Monthly Reading Progress")
                            .font(.headline)
                            .padding(.top)
                        
                        Chart(monthlyReadCount) { item in
                            BarMark(
                                x: .value("Month", item.month),
                                y: .value("Books Read", item.count)
                            )
                        }
                        .frame(height: 200)
                        .padding()
                        
                        Text("Genre Distribution")
                            .font(.headline)
                            .padding(.top)
                        
                        Chart(genreDistribution) { item in
                            SectorMark(
                                angle: .value("Books", item.count),
                                innerRadius: .ratio(0.5),
                                angularInset: 1.0
                            )
                            .foregroundStyle(by: .value("Genre", item.genre))
                        }
                        .frame(height: 200)
                        .padding()
                    } else {
                        Text("Loading insights...")
                    }
                }
                .padding()
            }
            .navigationTitle("Reading Insights")
        }
        .onAppear(perform: loadReadingStats)
    }
    
    func loadReadingStats() {
        // Load reading stats (implementation remains the same)
        // ...
        
        // Load genre distribution
        genreDistribution = getGenreDistribution()
    }
    
    func getGenreDistribution() -> [GenreCount] {
        let books = UserDefaults.standard.readingList
        var genreCounts: [String: Int] = [:]
        
        for book in books {
            for category in book.categories {
                genreCounts[category, default: 0] += 1
            }
        }
        
        return genreCounts.map { GenreCount(genre: $0.key, count: $0.value) }
    }
}

struct GenreCount: Identifiable {
    let id = UUID()
    let genre: String
    let count: Int
}