//
//  RealmOpeningView.swift
//  RealmProject
//
//  Created by Karin Prater on 13.03.22.
//

import SwiftUI
import RealmSwift

struct RealmOpeningView: View {
    
    // always need newest data, does not offline
//    @AsyncOpen(appId: "application-0-rvlot", partitionValue: "", timeout: 4000) var asyncOpen
    
    // always show data, offline
    @AutoOpen(appId: "application-0-rvlot", partitionValue: "", timeout: 4000) var realmOpen
    
    
    var body: some View {
        
        switch realmOpen {
            case .connecting:
                ProgressView("connecting ...")
                
            case .waitingForUser:
                ProgressView("waiting for user ...")
                
            case .progress(let progress):
                ProgressView(progress)
                    .padding(50)
                
            case .open(let realm):
                GroupLoadingView()
                    .environment(\.realm, realm)
                
            case .error(let error):
                Text("opening realm error: \(error.localizedDescription)")
                
        }
    }
}

struct RealmOpeningView_Previews: PreviewProvider {
    static var previews: some View {
        RealmOpeningView()
    }
}
