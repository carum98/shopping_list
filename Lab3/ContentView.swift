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
    @State var itemName : String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                inputItem
                listItems
            }
        }
    }
    
    var inputItem : some View {
        HStack {
            TextField("Ingresar articulo", text: self.$itemName)
            Button(action: addItem) {
                Text("Guardar")
            }
        }.padding()
    }
    
    var listItems : some View {
        List(self.itemsStore.items) { item in
            Text(item.name)
        }.navigationBarTitle("Lista de compra")
    }
    
    func addItem() {
        itemsStore.items.append(Item(id: itemsStore.items.count + 1, name: itemName))
        
        self.itemName = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
