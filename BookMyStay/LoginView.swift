import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var navigateToHome = false
    @State private var userData: [String: Any]?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                    
                // Gradient overlay with smoother color transitions
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.purple, .blue, .pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 1200, height: 500)
                    .rotationEffect(.degrees(125))
                    .offset(y: -300)
                
                // Additional layer for depth
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .foregroundStyle(
                        .radialGradient(
                            colors: [.yellow.opacity(0.5), .orange.opacity(0.3), .clear],
                            center: .center,
                            startRadius: 10,
                            endRadius: 500
                        )
                    )
                    .frame(width: 1400, height: 600)
                    .rotationEffect(.degrees(135))
                    .offset(y: -400)
                
                VStack(spacing: 20) {
                    Text("Log In")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -100, y: -100)
                    
                    TextField("Email", text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: email.isEmpty) {
                            Text("Email")
                                .foregroundColor(.white)
                                .bold()
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    SecureField("Password", text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: password.isEmpty) {
                            Text("Password")
                                .foregroundColor(.white)
                                .bold()
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    Button {
                        login()
                    } label: {
                        Text("Log In")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    .offset(y: 50)
                    
                    if showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.top, 10)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                    }
                    
                    NavigationLink(destination: ContentView()) {
                        Text("Don't have an account? Sign Up")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    .offset(y: 100)
                    
                    NavigationLink(destination: HotelFormView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                }
                .frame(width: 350)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                showError = true
            } else if let user = result?.user {
                // Fetch user data from Firestore
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).getDocument { document, error in
                    if let document = document, document.exists {
                        userData = document.data()
                        navigateToHome = true
                        showError = false
                    } else {
                        errorMessage = "User data not found in Firestore."
                        showError = true
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
