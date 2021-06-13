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
    @State var inputImage: UIImage?
    
    
    @State var showSheetView = false
    @State var showingImagePicker = false
    @State var isEditing = false
    @State var image: Image?
    
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
                    Section(header: Text("Imagen")) {
                        Button("Seleccionar Imagen", action: {
                            self.showingImagePicker = true
                        })
                    }
                    if (image != nil) {
                        image?.resizable().scaledToFit()
                    }
                }
                .navigationBarTitle("Nuevo articulo")
                .navigationBarItems(
                    leading:  Button("Cancelar", action: {showSheetView = false}),
                    trailing:  Button("Guardar", action: { showSheetView = false; addItem() })
                )
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
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
        .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
        .navigationBarTitle("Lista de compra")
        .navigationBarItems(
            leading: deleteButton, trailing: editButton
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
    
    private var editButton : some View {
        Button(action: {
            self.isEditing.toggle()
        }) {
            Text(isEditing ? "Cancelar" : "Editar")
                .frame(height: 40)
        }
    }
    
    private func addItem() {
        let item = Item(
            id: itemsStore.items.count + 1,
            name: itemName,
            description: itemDescription,
            image: image
        );
        itemsStore.items.append(item)
        
        self.itemName = ""
        self.itemDescription = ""
        self.image = nil
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
