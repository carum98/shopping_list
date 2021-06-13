//
//  RowItem.swift
//  Lab3
//
//  Created by Carlos Eduardo Umaña Acevedo on 13/6/21.
//

import SwiftUI

struct RowItem: View {
    let item : Item;
    
    var body: some View {
        HStack {
            Image(systemName: "cloud.heavyrain.fill").cornerRadius(8)
            VStack(alignment: .leading) {
                Text(item.name).bold()
                Text(item.description).foregroundColor(.gray)
            }
        }

    }
}

struct RowItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RowItem(item: Item(id: 1, name: "Leche", description: "Esta es la descripcion del articulo", path: ""))
            RowItem(item: Item(id: 1, name: "Leche", description: "Esta es la descripcion del articulo", path: ""))
            }
            .previewLayout(.fixed(width: 300, height: 70))
        
       
    }
}
