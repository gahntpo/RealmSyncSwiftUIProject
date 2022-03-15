//
//  GroupLoadingView.swift
//  RealmProject
//
//  Created by Karin Prater on 13.03.22.
//

import SwiftUI
import RealmSwift


struct GroupLoadingView: View {
    @ObservedResults(Group.self) var groups
    
    var body: some View {
        
        if let group = groups.first {
            ItemListView(group: group)
        } else {
            ProgressView()
                .onAppear {
                    $groups.append(Group())
                }
        }
    }
}

struct GroupLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        GroupLoadingView()
    }
}
