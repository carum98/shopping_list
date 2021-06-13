//
//  Item.swift
//  Lab3
//
//  Created by Carlos Eduardo Umaña Acevedo on 13/6/21.
//

import Foundation
import SwiftUI

struct Item : Identifiable {
    let id: Int;
    var name: String;
    var description: String;
    var image: Image?;
}
