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
        List {
            ForEach(self.itemsStore.items, id: \.id) { item in
                Text(item.name)
            }
            .onMove {
                itemsStore.items.move(fromOffsets: $0, toOffset: $1)
            }
            .onDelete {
                itemsStore.items.remove(atOffsets: $0)
            }
        }
        .navigationBarTitle("Lista de compra")
        .navigationBarItems(trailing: EditButton())
        .overlay(Group {
             if self.itemsStore.items.isEmpty {
                VStack {
                    Image(systemName: "archivebox")
                        .font(.system(size: 50))
                        .foregroundColor(Color.gray)
                    Text("Lista vacia")
                        .font(.system(size: 30))
                        .foregroundColor(Color.gray)
                }
             }
         })
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
