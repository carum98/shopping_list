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
    @State var modifyList = false

    @State var isEditing = false
    
    @State var image: Image?
    
    var body: some View {
        NavigationView {
            ZStack {
                listItems
                floatingActionButton
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showSheetView, onDismiss: clearState, content: {
            formCreateItem
        })
    }
    
    private var listItems : some View {
        List {
            ForEach(self.itemsStore.items, id: \.id) { item in
                RowItem(item: item).onTapGesture {
                    openItem(item: item)
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
        .environment(\.editMode, .constant(self.modifyList ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
        .navigationBarTitle("Lista de compra")
        .navigationBarItems(
            leading: deleteButton, trailing: editButton
        )
        .overlay(Group {
            if self.itemsStore.items.isEmpty {
                emptyList
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
            self.modifyList.toggle()
        }) {
            Text(modifyList ? "Cancelar" : "Modificar")
                .frame(height: 40)
        }
    }
    
    private var formCreateItem : some View {
        NavigationView {
            Form {
                Section(header: Text("Nombre")) {
                    TextField("Nombre del articulo", text: $itemName)
                }
                Section(header: Text("Description")) {
                    TextField("Descripcion del articulo", text: $itemDescription)
                }
                if (image != nil) {
                    image?.resizable().scaledToFit()
                } else {
                    Section(header: Text("Imagen")) {
                        Button("Seleccionar Imagen", action: {
                            self.showingImagePicker = true
                        })
                    }
                }
            }
            .navigationBarTitle(isEditing ? "Editar articulo" : "Nuevo articulo")
            .navigationBarItems(
                leading: Button("Cancelar", action: {
                        showSheetView = false
                        clearState()
                }),
                trailing: Button(
                    isEditing ? "Aplicar" : "Guardar",
                     action: {
                        showSheetView = false;
                        isEditing ? editItem(index: 0) : addItem()
                     })
                    .disabled(itemName.isEmpty || itemDescription.isEmpty || image == nil)
            )
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    private var emptyList : some View {
       VStack {
           Image(systemName: "archivebox")
               .font(.system(size: 50))
               .foregroundColor(Color.gray)
           Text("Lista vacia")
               .font(.system(size: 30))
               .foregroundColor(Color.gray)
       }
    }
    
    private func openItem(item: Item) {
        showSheetView = true
        isEditing = true
        
        itemName = item.name
        itemDescription = item.description
        image = item.image
    }
    
    private func addItem() {
        let item = Item(
            id: itemsStore.items.count + 1,
            name: itemName,
            description: itemDescription,
            image: image
        );
        
        itemsStore.items.append(item)
    }
    
    private func editItem(index : Int) {
        self.itemsStore.items[index].name = itemName
        self.itemsStore.items[index].description = itemDescription
    }
    
    private func clearState() {
        self.itemName = ""
        self.itemDescription = ""
        self.image = nil
        
        self.isEditing = false
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
