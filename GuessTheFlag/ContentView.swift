//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Cassandra Camacho on 6/19/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in:0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var alertMessage = ""
    @State private var countOfFlagsTapped = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number: number)
                        } label: {
                            FlagView(imageName: countries[number])
                        }
                    }
                    
                    
                    Text("Score: \(userScore)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
            
            Spacer()
            Spacer()
            
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button(countOfFlagsTapped < 8 ? "Continue" : "Restart",
            action: countOfFlagsTapped < 8 ? askQuestion : resetGame)
        } message: {
            Text(alertMessage)
        }
    }
    
    func flagTapped (number: Int) {
        countOfFlagsTapped += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            alertMessage = "Correct!"
        } else {
            scoreTitle = "Wrong"
            alertMessage = "Wrong! That's the flag of \(countries[number])"
            
        }; if countOfFlagsTapped == 8 {
            scoreTitle = "Game Over"
            alertMessage = "Your final score \(userScore)"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in:0...2)
        
    }
    func resetGame() {
        countOfFlagsTapped = 0
        userScore = 0
        countries.shuffle()
        correctAnswer = Int.random(in:0...2)
    }
    
    struct FlagView: View {
        var imageName: String
            
        var body: some View {
            Image(imageName)
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
    }
    }
    
        


#Preview {
    ContentView()
}
