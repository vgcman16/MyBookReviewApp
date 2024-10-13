import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authService: AuthenticationService
    @EnvironmentObject var firestoreService: FirestoreService
    @State private var booksRead: Int = 0
    @State private var averageRating: Double = 0.0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Information")) {
                    Text("Email: \(authService.user?.email ?? "N/A")")
                }
                
                Section(header: Text("Reading Statistics")) {
                    Text("Books Read: \(booksRead)")
                    Text("Average Rating: \(averageRating, specifier: "%.1f")")
                }
                
                Section {
                    Button("Logout") {
                        authService.signOut()
                    }
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear(perform: loadUserData)
    }
    
    func loadUserData() {
        if let userId = authService.user?.uid {
            firestoreService.getBooks(userId: userId) { result in
                switch result {
                case .success(let books):
                    booksRead = books.count
                    averageRating = books.reduce(0.0) { $0 + Double($1.rating) } / Double(books.count)
                case .failure(let error):
                    print("Error fetching user data: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthenticationService())
            .environmentObject(FirestoreService())
    }
}