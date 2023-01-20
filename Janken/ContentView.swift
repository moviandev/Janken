//
//  ContentView.swift
//  Janken
//
//  Created by Matheus Viana on 18/01/23.
//

import SwiftUI

struct Title: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle.bold())
            .foregroundStyle(.secondary)
    }
}

struct EmojiButton: View {
    var emoji: String
    
    var body: some View {
        Text(emoji)
            .font(.system(size: 60))
    }
}

struct Background: View {
    var changeBackground: Bool
    
    var body: some View {
        !changeBackground ?
        RadialGradient(stops: [
            .init(color: Color(red: 1, green: 0.879, blue: 0.360), location: 0.3),
            .init(color: Color(red: 0, green: 0.708, blue: 0), location: 0.3)], center: .top, startRadius: 60, endRadius: 350)
        .ignoresSafeArea() :
        RadialGradient(stops: [
            .init(color: Color(red: 0, green: 0.708, blue: 0), location: 0.3),
            .init(color: Color(red: 1, green: 0.879, blue: 0.360), location: 0.3)], center: .top, startRadius: 60, endRadius: 350)
        .ignoresSafeArea()
        
    }
}

struct ContentView: View {
    @State private var moves = ["🪨", "📄", "✂️"]
        .shuffled()

    @State private var shouldWin = Bool.random()
    @State private var appMove = Int.random(in: 0..<3)
    @State private var score = 0
    
    var body: some View {
        ZStack {
            Background(changeBackground: shouldWin)
            
            VStack(spacing: 30) {
                Title(text: "Janken Game")
                
                HStack(spacing: 50) {
                    ForEach(0..<3, id: \.self) {number in
                        Button {
                            tappedEmoji(number)
                        } label: {
                            EmojiButton(emoji: moves[number])
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    func tappedEmoji(_ userChoice: Int) {
        if shouldWin && appMove == userChoice {
            score +=  1
        } else {
            score -= 1
        }
        
        shouldWin.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
