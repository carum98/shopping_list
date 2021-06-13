//
//  Store.swift
//  Lab3
//
//  Created by Carlos Eduardo Umaña Acevedo on 7/6/21.
//

import Foundation
import Combine

class ItemsStore : ObservableObject {
    @Published var items = [Item]()
}
