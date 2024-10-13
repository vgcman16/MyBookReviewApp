import Foundation

struct ReadingGoal: Identifiable, Codable {
    let id = UUID()
    var booksGoal: Int
    var startDate: Date
    var endDate: Date
    var booksRead: Int
}