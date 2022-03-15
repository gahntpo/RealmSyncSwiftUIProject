//
//  LoginView.swift
//  RealmProject
//
//  Created by Karin Prater on 13.03.22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var authManager = AuthenticationManager()
    
    var body: some View {
        VStack {
            
            Text("Login")
                .font(.title)
            
            TextField("email", text: $authManager.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("password", text: $authManager.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if authManager.isLoading {
                ProgressView()
            }
            
            if let error = authManager.errorMessage {
                Text(error)
                    .foregroundColor(.pink)
            }
            
            HStack {
                
                Button {
                    authManager.signup()
                } label: {
                    Text("sign up")
                }
                .buttonStyle(.bordered)
                .disabled(!authManager.authIsEnabled)
                
                Button {
                    authManager.login()
                } label: {
                    Text("log in")
                }
                .buttonStyle(.borderedProminent)
                .disabled(!authManager.authIsEnabled)
          
            }
            .padding()
            
            Button("Log in anonymously") {
                authManager.anonymouslyLogin()
            }
            .disabled(authManager.isLoading)
            
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
