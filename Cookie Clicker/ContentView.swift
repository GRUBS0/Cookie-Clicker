//
//  ContentView.swift
//  Cookie Clicker
//
//  Created by Joseph Phillips on 11/20/25.
//

import SwiftUI   // Import SwiftUI framework for UI building

struct ContentView: View {
    
    // MARK: - Game state variables
    @State private var score = 0   // Counts taps
    @State private var highScore =
        UserDefaults.standard.integer(forKey: "HighScore") // Loads saved high score
    @State private var timeLeft = 10        // Countdown timer starts at 10
    @State private var running = false      // Tracks if game is active
    @State private var showAlert = false    // Controls "Time's Up!" popup
    
    var body: some View {
        VStack(spacing: 20) {   // Vertical stack of UI elements with 20 spacing
            
            // COOKIE IMAGE
            Image("cookie")
                .resizable()               // Makes image resizable
                .frame(width: 200, height: 200)  // Sets size
                .onTapGesture {            // Action when cookie is tapped
                    cookiePressed()
                }
            
            // CURRENT SCORE DISPLAY
            Text("Score: \(score)")
                .font(.largeTitle)        // Large font for visibility
            
            // HIGH SCORE DISPLAY
            Text("High Score: \(highScore)")
                .font(.title3)            // Smaller font for secondary info
            
            // TIME LEFT DISPLAY
            Text("Time: \(timeLeft)")
                .font(.title)             // Medium font for timer
            
            Spacer()                     // Pushes content up
            
            // RESET BUTTON
            Button("Reset") {
                reset()                  // Calls reset function
            }
            .font(.title2)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)           // Rounded corners
        }
        .padding()
        
        // ALERT WHEN TIME ENDS
        .alert("Time's Up!", isPresented: $showAlert) {
            Button("OK") { reset() }     // Reset game when alert dismissed
        } message: {
            Text("You tapped \(score) times.")  // Shows final score
        }
    }
    
    // MARK: - Functions
    
    // Called when user taps cookie
    func cookiePressed() {
        if running {
            score += 1              // Increase score only while game is active
        } else {
            startGame()             // Start game if not already running
        }
    }
    
    // Starts the game
    func startGame() {
        reset()                     // Reset everything to start fresh
        running = true              // Set game to active
        
        // SIMPLE TIMER
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            timeLeft -= 1           // Count down each second
            
            if timeLeft == 0 {
                timer.invalidate()  // Stop timer when it reaches 0
                endGame()           // Handle end of game
            }
        }
    }
    
    // Ends the game
    func endGame() {
        running = false             // Stop game
        
        // SAVE HIGH SCORE
        if score > highScore {
            highScore = score       // Update high score
            UserDefaults.standard.set(highScore, forKey: "HighScore") // Save to device
        }
        
        showAlert = true            // Show "Time's Up!" alert
    }
    
    // Resets game to initial state
    func reset() {
        score = 0
        timeLeft = 10
        running = false
    }
}

#Preview {
    ContentView()
}
