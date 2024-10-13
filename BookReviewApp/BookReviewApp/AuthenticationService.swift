import Foundation
import FirebaseAuth

class AuthenticationService: ObservableObject {
    @Published var user: User?
    
    init() {
        user = Auth.auth().currentUser
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                self?.user = user
                completion(.success(user))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                self?.user = user
                completion(.success(user))
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}