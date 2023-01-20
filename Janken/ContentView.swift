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
            .init(color: Color(red: 0, green: 0.708, blue: 0), location: 0.3)], center: .top, startRadius: 30, endRadius: 300)
        .ignoresSafeArea() :
        RadialGradient(stops: [
            .init(color: Color(red: 0, green: 0.708, blue: 0), location: 0.3),
            .init(color: Color(red: 1, green: 0.879, blue: 0.360), location: 0.3)], center: .top, startRadius: 30, endRadius: 300)
        .ignoresSafeArea()
        
    }
}

struct ContentView: View {
    @State private var moves = ["🪨", "📄", "✂️"]
        .shuffled()
    
    @State private var shouldWin = Bool.random()
    @State private var appMove = Int.random(in: 0..<3)
    @State private var score = 0
    @State private var rounds = 0
    @State private var showingGameOver = false
    
    var body: some View {
        ZStack {
            Background(changeBackground: shouldWin)
            
            VStack {
                Spacer()
                Spacer()
                VStack {
                    Title(text: "Janken Game")
                    VStack {
                        Text("App's choice: \(moves[appMove])")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        HStack(spacing: 50) {
                            ForEach(0..<3, id: \.self) {number in
                                Button {
                                    tappedEmoji(number)
                                } label: {
                                    EmojiButton(emoji: moves[number])
                                }
                                .alert("Game over!", isPresented: $showingGameOver) {
                                    Button("Play again", role: .cancel, action: playAgain)
                                } message: {
                                    Text("Do you wanna play again?")
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Spacer()
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
        }
    }
    
    func tappedEmoji(_ userChoice: Int) {
        if shouldWin && isWinner(moves[appMove], moves[userChoice]) && moves[appMove] != moves[userChoice] {
            score +=  1
        } else if moves[appMove] == moves[userChoice] {
            score = score
        } else {
            if !shouldWin && !isWinner(moves[appMove], moves[userChoice]) {
             score += 1
            } else {
                score -= score > 0 ? 1 : 0
            }
        }
        
        rounds += 1
        
        if rounds == 6 {
            showingGameOver = true
            return
        }
        
        chooseAgain()
    }
    
    func chooseAgain() {
        appMove = Int.random(in: 0..<3)
        shouldWin.toggle()
    }
    
    func playAgain() {
        score = 0
        chooseAgain()
    }
    
    func isWinner(_ appChoice: String, _ choosed: String) -> Bool {
        switch appChoice {
        case "✂️":
            return choosed == "🪨"
        case "📄":
            return choosed == "✂️"
        case "🪨":
            return choosed == "📄"
        default:
            return false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
