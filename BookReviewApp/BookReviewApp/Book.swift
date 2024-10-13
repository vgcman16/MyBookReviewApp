import Foundation
import FirebaseFirestoreSwift

struct Book: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var author: String
    var rating: Int
    var review: String
    var isInReadingList: Bool = false
    var thumbnail: String = ""
    var categories: [String] = []
    var publishedDate: String = ""
    var pageCount: Int?
}