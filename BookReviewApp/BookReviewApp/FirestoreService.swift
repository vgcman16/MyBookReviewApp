import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService: ObservableObject {
    private let db = Firestore.firestore()
    
    func addBook(_ book: Book, userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try db.collection("users").document(userId).collection("books").addDocument(from: book)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func getBooks(userId: String, completion: @escaping (Result<[Book], Error>) -> Void) {
        db.collection("users").document(userId).collection("books").getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let books = snapshot?.documents.compactMap { try? $0.data(as: Book.self) } ?? []
                completion(.success(books))
            }
        }
    }
    
    func updateBook(_ book: Book, userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let bookId = book.id else {
            completion(.failure(NSError(domain: "FirestoreService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Book ID is missing"])))
            return
        }
        
        do {
            try db.collection("users").document(userId).collection("books").document(bookId).setData(from: book)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteBook(bookId: String, userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(userId).collection("books").document(bookId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}