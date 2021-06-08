//
//  ContentView.swift
//  Lab3
//
//  Created by Carlos Eduardo Umaña Acevedo on 7/6/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("Carlos")
                    Text("Carlos")
                    Text("Carlos")
                    Text("Carlos")
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
