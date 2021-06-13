//
//  DetailItem.swift
//  Lab3
//
//  Created by Carlos Eduardo Umaña Acevedo on 13/6/21.
//

import SwiftUI

struct DetailItem: View {
    var item : Item;
    
    var body: some View {
        VStack {
            VStack {
                Text(item.name)
                Text(item.description)
            }
        }
    }
}

struct DetailItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailItem(item: Item(id: 1, name: "Item 1", description: "Description"))
    }
}
