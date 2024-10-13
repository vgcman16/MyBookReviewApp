import Foundation

struct BookQuote: Identifiable, Codable {
    let id = UUID()
    let text: String
    let book: String
    let author: String
    let date: Date
}