//
//  ItemListView.swift
//  RealmProject
//
//  Created by Karin Prater on 12.03.22.
//

import SwiftUI
import RealmSwift

struct ItemListView: View {
    
    // @State
    @ObservedRealmObject var group: Group
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(group.items) { item in
                    ItemRow(item: item)
                }
                .onMove(perform: $group.items.move)
                .onDelete(perform: { offset in
                    if let index = offset.first {
                        let item = group.items[index]
                        $group.items.remove(atOffsets: offset)
                        
                        if let item = item.thaw(),
                            let realm = item.realm {
                            try? realm.write({
                                realm.delete(item)
                            })
                        }
                    }
                   
                    
                })
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Items", displayMode: .large)
            .navigationBarBackButtonHidden(true)
          
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Log out") {
                        AuthenticationManager.logout()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        $group.items.append(Item())
                    } label: {
                        Image(systemName: "plus")
                    }.frame(maxWidth: .infinity, alignment: .trailing)

                }
            }
        }
    }
}

struct ItemRow: View {
    
    @ObservedRealmObject var item: Item
    
    var body: some View {
        // You can click an item in the list to navigate to an edit details screen.
        NavigationLink(destination: ItemDetailView(item: item)) {
            Text(item.name)
            if item.isFavorite {
                // If the user "favorited" the item, display a heart icon
                Image(systemName: "heart.fill")
            }
        }
    }
}


struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(group: Group())
    }
}
