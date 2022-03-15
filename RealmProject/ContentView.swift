//
//  ContentView.swift
//  RealmProject
//
//  Created by Karin Prater on 12.03.22.
//

import SwiftUI
import RealmSwift


struct ContentView: View {
    
    @ObservedObject var app: RealmSwift.App
    
    var body: some View {
        if let user = app.currentUser {
            RealmOpeningView()
                .environment(\.partitionValue, user.id)
           
        }
        else {
            LoginView()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//       ContentView()
//    }
//}
