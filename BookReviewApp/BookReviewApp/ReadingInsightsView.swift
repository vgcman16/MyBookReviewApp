import SwiftUI
import Charts

struct ReadingInsightsView: View {
    @State private var readingStats: ReadingStats?
    @State private var monthlyReadCount: [MonthlyReadCount] = []
    
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
        let readBooks = UserDefaults.standard.readingList.filter { $0.rating > 0 }
        let totalPages = readBooks.reduce(0) { $0 + ($1.pageCount ?? 0) }
        let averageRating = readBooks.reduce(0.0) { $0 + Double($1.rating) } / Double(readBooks.count)
        let favoriteGenre = getFavoriteGenre(from: readBooks)
        
        readingStats = ReadingStats(
            booksRead: readBooks.count,
            totalPages: totalPages,
            averageRating: averageRating,
            favoriteGenre: favoriteGenre
        )
        
        monthlyReadCount = getMonthlyReadCount(from: readBooks)
    }
    
    func getFavoriteGenre(from books: [Book]) -> String {
        let genreCounts = books.flatMap { $0.categories }.reduce(into: [:]) { counts, genre in
            counts[genre, default: 0] += 1
        }
        return genreCounts.max(by: { $0.value < $1.value })?.key ?? "N/A"
    }
    
    func getMonthlyReadCount(from books: [Book]) -> [MonthlyReadCount] {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        
        var monthlyCounts: [String: Int] = [:]
        
        for book in books {
            if let date = calendar.date(from: DateComponents(year: currentYear, month: Int.random(in: 1...12), day: 1)) {
                let monthName = DateFormatter().monthSymbols[calendar.component(.month, from: date) - 1]
                monthlyCounts[monthName, default: 0] += 1
            }
        }
        
        return monthlyCounts.map { MonthlyReadCount(month: $0.key, count: $0.value) }
            .sorted { DateFormatter().monthSymbols.firstIndex(of: $0.month)! < DateFormatter().monthSymbols.firstIndex(of: $1.month)! }
    }
}

struct MonthlyReadCount: Identifiable {
    let id = UUID()
    let month: String
    let count: Int
}