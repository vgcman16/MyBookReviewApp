import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        NavigationView {
            if authService.user != nil {
                TabView {
                    BookListView()
                        .tabItem {
                            Label("Books", systemImage: "book")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                }
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthenticationService())
    }
}