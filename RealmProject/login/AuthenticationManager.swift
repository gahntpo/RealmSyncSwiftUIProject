//
//  AuthenticationManager.swift
//  RealmProject
//
//  Created by Karin Prater on 13.03.22.
//

import Foundation
import RealmSwift

class AuthenticationManager: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    var authIsEnabled: Bool {
        email.count > 5 && password.count > 5
    }
    
    var enableButtons: Bool {
        !isLoading && authIsEnabled
    }
    
    func anonymouslyLogin() {
        
        isLoading = true
        errorMessage = nil
        
        app.login(credentials: .anonymous) { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                    case .success(_):
                        print("success anonymously logged in")
                    case .failure(_):
                        self?.errorMessage = "login failed"
                }
                self?.isLoading = false
            }
        }
    }
    
    
    func signup() {
        
        let client = app.emailPasswordAuth
        
        isLoading = true
        errorMessage = nil
        
        client.registerUser(email: email, password: password) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "signup error: \(error.localizedDescription)"
                    self?.isLoading = false
                }
                else {
                    self?.login()
                }
            }
            
        }
    }
    
    func login() {
        
        isLoading = true
        errorMessage = nil
        
        let credentials = Credentials.emailPassword(email: email, password: password)
        
        app.login(credentials: credentials) { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                    case .failure(let error): self?.errorMessage = "login failed: \(error.localizedDescription)"
                    case .success(_): print("login success")
                }
                self?.isLoading = false
            }
        }
    }
    
    
   static func logout() {
        app.currentUser?.logOut(completion: { error in
            if let error = error {
                print("error logout \(error)")
            }
        })
    }
    
}
