//
//  ContentView.swift
//  Lab3
//
//  Created by Carlos Eduardo Umaña Acevedo on 7/6/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var itemsStore = ItemsStore()
    
    var body: some View {
        NavigationView {
            VStack {
                List(self.itemsStore.items) { item in
                    Text(item.name)
                }.navigationBarTitle("Lista de compra")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
