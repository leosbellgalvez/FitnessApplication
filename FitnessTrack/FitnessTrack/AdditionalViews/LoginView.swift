import Foundation
import SwiftUI
import ParseSwift

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var showAlert = false
    @State private var error_message = ""
    @State private var isSignUp = false
    @State private var loading = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Fitness Track")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 50)
                
                Spacer()
                
                VStack(spacing: 15) {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    
                    if isSignUp {
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal, 30)
                
                if loading {
                    ProgressView()
                        .padding()
                } else {
                    Button(action: isSignUp ? signUp : login) {
                        Text(isSignUp ? "Sign Up" : "Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)
                    
                    Button(action: { isSignUp.toggle()}) {
                        Text(isSignUp ? "Already have an account? Login" : "Don't have an account? Sign Up")
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Message"), message: Text(error_message), dismissButton: .default(Text("Alright!")))
            }
        }
    }
    
    func login() {
        loading = true
        User.login(username: username, password: password) { result in
            loading = false
            switch result {
            case .success:
                isLoggedIn = true
            case .failure(let error):
                error_message = error.localizedDescription
                showAlert.toggle()
            }
        }
    }
    
    func signUp() {
        loading = true
        // Create a new user and set fields
        var newUser = User()
        newUser.username = username
        newUser.password = password
        if !email.isEmpty {
            newUser.email = email
        }

        newUser.signup { result in
            loading = false
            switch result {
            case .success:
                isLoggedIn = true
            case .failure(let error):
                error_message = error.localizedDescription
                showAlert.toggle()
            }
        }
    }
}
