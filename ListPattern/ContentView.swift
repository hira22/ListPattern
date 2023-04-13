//
//  ContentView.swift
//  ListPattern
//
//  Created by hiraoka on 2021/07/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("SwiftUI", destination: SwiftUIListView())
                NavigationLink("Swift", destination: SwiftListView())
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
