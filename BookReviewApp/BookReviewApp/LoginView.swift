import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Sign In") {
                authService.signIn(email: email, password: password) { result in
                    switch result {
                    case .success:
                        // Handle successful sign-in
                        break
                    case .failure(let error):
                        alertMessage = error.localizedDescription
                        showingAlert = true
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            NavigationLink("Don't have an account? Sign Up", destination: SignUpView())
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthenticationService())
    }
}