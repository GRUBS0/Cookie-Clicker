//
//  ContentView.swift
//  Cookie Clicker
//
//  Created by joseph phillips on 11/20/25.
//

import SwiftUI
struct ContentView: View {
    
    @State private var score = 0      // Counts taps
    @State private var timeLeft = 10  // Countdown timer
    @State private var running = false// Is the game active?
    @State private var timer: Timer?  = nil // Holds timer so we can stop it
    @State private var showAlert = false    // Shows popup when time ends
    var body: some View {
        VStack(spacing: 20) {         // Vertical layout with spacing
            Image("cookie")           // Cookie graphic
                .resizable()
                .frame(width: 100, height: 100)
                .onTapGesture {       // When user taps cookie:
                    if running {      // Only count if game is running
                        score += 1    // Increase score
                    }
                }
            // Score Display
            Text("Score: \(score)")   // Shows score
                .font(.largeTitle)
                .padding()
            
            // Time Display
            Text("Time: \(timeLeft)") // Shows remaining time
                .font(.title)
            Spacer()                  // Pushes buttons to bottom
            // Buttons
            HStack {
                Button("Start") {     // Start button begins the game
                    startGame()
                }
                .font(.title2)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                Button("Reset") {     // Reset button clears everything
                    reset()
                }
                .font(.title2)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        
        // ---- Pop up when time ends
        .alert("Time's Up!", isPresented: $showAlert) {
            Button("OK") { reset() }
        } message: {
            Text("You tapped \(score) times.")
        }
    }
    func startGame() {
        reset()               // Always start fresh
        running = true        // Game is active
        
        // Timer that counts down once per second
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            timeLeft -= 1     // Decrease timer by 1
            
            if timeLeft == 0 {      // When timer hits 0:
                running = false     // Stop the game
                timer?.invalidate() // Stop the timer
                showAlert = true    // Show popup
            }
        }
    }
}
