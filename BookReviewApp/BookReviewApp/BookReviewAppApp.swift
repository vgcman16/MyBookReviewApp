import SwiftUI
import Firebase

@main
struct BookReviewAppApp: App {
    @StateObject var authService = AuthenticationService()
    @StateObject var firestoreService = FirestoreService()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authService)
                .environmentObject(firestoreService)
        }
    }
}