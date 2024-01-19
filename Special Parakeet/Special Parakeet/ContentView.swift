//
//  ContentView.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 15/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var presentedBirds: [Bird] = []
    
    var body: some View {
        NavigationStack(path: $presentedBirds) {
            TabView {
                BirdsListView(presentedBirds: $presentedBirds).tabItem {
                    Label("Birds", systemImage: "bird.circle.fill")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
