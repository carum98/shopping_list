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
    @State var itemDescription : String = ""
    
    
    @State var showSheetView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    listItems
                }
                floatingActionButton
            }

        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showSheetView, content: {
            NavigationView {
                Form {
                    Section(header: Text("Nombre")) {
                        TextField("Nombre del articulo", text: $itemName)
                    }
                    Section(header: Text("Description")) {
                        TextField("Descripcion del articulo", text: $itemDescription)
                    }
                }
                .navigationBarTitle("Nuevo articulo")
                .navigationBarItems(
                    leading:  Button("Cancelar", action: {showSheetView = false}),
                    trailing:  Button("Guardar", action: { showSheetView = false; addItem() })
                )
            }
        })
    }
    
    private var listItems : some View {
        List {
            ForEach(self.itemsStore.items, id: \.id) { item in
                NavigationLink(
                    destination: Text(item.name)) {
                    RowItem(item: item)
                }
            }
            .onMove {
                itemsStore.items.move(fromOffsets: $0, toOffset: $1)
            }
            .onDelete {
                itemsStore.items.remove(atOffsets: $0)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Lista de compra")
        .navigationBarItems(
            leading: deleteButton, trailing: EditButton()
        )
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
         }
        )
    }
    
    private var floatingActionButton : some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showSheetView = true
                }, label: {
                    Text("+")
                    .font(.system(.largeTitle))
                    .frame(width: 67, height: 60)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 7)
                })
                .background(Color.blue)
                .cornerRadius(38.5)
                .padding()
                
            }
        }
    }
    
    private var deleteButton : some View {
        Button(action: { itemsStore.items.removeAll() }) {
            HStack {
                Image(systemName: "trash")
                Text("Borrar todo")
            }
            
        }
    }
    
    private func addItem() {
        let item = Item(
            id: itemsStore.items.count + 1,
            name: itemName,
            description: itemDescription,
            path: ""
        );
        itemsStore.items.append(item)
        
        self.itemName = ""
        self.itemDescription = ""
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
