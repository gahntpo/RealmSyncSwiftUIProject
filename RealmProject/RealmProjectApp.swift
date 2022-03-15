//
//  RealmProjectApp.swift
//  RealmProject
//
//  Created by Karin Prater on 12.03.22.
//

import SwiftUI
import RealmSwift

let app = App(id: "application-0-rvlot")

@main
struct RealmProjectApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            
            ContentView(app: app)
            
        }
    }
}
