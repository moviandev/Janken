//
//  ContentView.swift
//  Janken
//
//  Created by Matheus Viana on 18/01/23.
//

import SwiftUI

struct ContentView: View {
    @State private var 
    
    
    let moves = ["🪨", "📄", "✂️"]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
