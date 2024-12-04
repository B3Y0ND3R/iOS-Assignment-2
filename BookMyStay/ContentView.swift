//
//  ContentView.swift
//  BookMyStay
//
//  Created by Shoumik Barman Polok on 8/11/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var role = "user"
    @State private var userIsLoggedIn: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                       colors: [.indigo, .purple, .blue],
                       startPoint: .top,
                       endPoint: .bottom
                   )
                   .ignoresSafeArea()
                   
                   // Enhanced rounded rectangle with gradient
                   RoundedRectangle(cornerRadius: 50, style: .continuous)
                       .foregroundStyle(
                           .linearGradient(
                               colors: [.pink, .red, .orange],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing
                           )
                       )
                       .frame(width: 1200, height: 500)
                       .rotationEffect(.degrees(125))
                       .offset(y: -300)
                   
                   // Additional layer for glowing effect
                   RoundedRectangle(cornerRadius: 50, style: .continuous)
                       .foregroundStyle(
                           .radialGradient(
                               colors: [.yellow.opacity(0.3), .white.opacity(0.1), .clear],
                               center: .center,
                               startRadius: 20,
                               endRadius: 600
                           )
                       )
                       .frame(width: 1400, height: 600)
                       .rotationEffect(.degrees(135))
                       .offset(y: -400)
                
                VStack(spacing: 20) {
                    Text("Welcome")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -100, y: -100)
                    
                    TextField("Name", text: $name)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: name.isEmpty) {
                            Text("Name")
                                .foregroundColor(.white)
                                .bold()
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
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
                        register()
                    } label: {
                        Text("Sign Up")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    .offset(y: 100)
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Already Have an Account? Sign In")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    .offset(y: 100)
                }
                .frame(width: 350)
                .onAppear(){
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil {
                            userIsLoggedIn.toggle()
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let userData = [
                "name": name,
                "email": email,
                "role": role,
                "uid": uid
            ]
            
            let db = Firestore.firestore()
            db.collection("users").document(uid).setData(userData) { error in
                if let error = error {
                    print("Error saving user data: \(error.localizedDescription)")
                } else {
                    print("User data saved successfully!")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
