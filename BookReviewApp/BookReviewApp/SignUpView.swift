import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
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
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Sign Up") {
                if password == confirmPassword {
                    authService.signUp(email: email, password: password) { result in
                        switch result {
                        case .success:
                            // Handle successful sign-up
                            break
                        case .failure(let error):
                            alertMessage = error.localizedDescription
                            showingAlert = true
                        }
                    }
                } else {
                    alertMessage = "Passwords do not match"
                    showingAlert = true
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(AuthenticationService())
    }
}