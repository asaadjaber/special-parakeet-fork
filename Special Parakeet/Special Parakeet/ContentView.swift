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
            BirdsListView(presentedBirds: $presentedBirds)
        }
    }
}

#Preview {
    ContentView()
}
