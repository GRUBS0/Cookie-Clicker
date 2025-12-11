//
//  ContentView.swift
//  Three Letter Word
//
//  Created by joseph phillips on 12/11/25.
//
import SwiftUI
struct ContentView: View {
    @State private var score = 0
    // Stores your score while you play
    
    @State private var highScore =
    UserDefaults.standard.integer(forKey: "HighScore")
    // Loads the saved high score from the device
    
    @State private var timeLeft = 10
    // How many seconds remain on the timer
    
    @State private var running = false
    // Tells us if the game is currently going
    
    @State private var showAlert = false
    // Controls “Time’s Up!” popup
    
    // Cookie starting position
    @State private var xPos: CGFloat = 200
    @State private var yPos: CGFloat = 400
    // These control where the cookie is on the screen
    var body: some View {
        ZStack {   // Layers things on top of each other
            Color.white
                .ignoresSafeArea()   // Makes background fill whole screen
            // Cookie Image (THAT MOVES)
            Image("cookie")
                .resizable()               // Allows image to resize
                .frame(width: 100, height: 100)
                .position(x: xPos, y: yPos)  // Puts cookie at current position
                .onTapGesture {              // When you tap cookie:
                    cookiePressed()          // Run this function
                }
            // Score, High Score, Timer, Reset Button
            VStack {
                Text("Score: \(score)")   // Shows current score
                    .font(.largeTitle)
                Text("High Score: \(highScore)") // Shows highest score ever saved
                    .font(.title3)
                Text("Time: \(timeLeft)")     // Shows time left
                    .font(.title)
                Spacer()                     // Pushes reset button to the bottom
                Button("Reset") {            // Reset button
                    reset()
                }
                .font(.title2)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        // "Time's Up!" popup
        .alert("Time's Up!", isPresented: $showAlert) {
            Button("OK") { reset() }  // Reset when popup closes
        } message: {
            Text("You tapped \(score) times.")
        }
    }
    // Called when cookie is tapped
    func cookiePressed() {
        if running {
            score += 1    // Add to score
            // Move cookie to random position
            xPos = CGFloat.random(in: 50...350)
            yPos = CGFloat.random(in: 150...750)
        } else {
            // If game hasn't started yet, start it
            startGame()
        }
    }
    // Starts game + timer
    func startGame() {
        reset()         // Reset score and timer
        running = true  // Game is now active
        
        // Simple 1-second repeating timer
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            timeLeft -= 1    // Count down
            
            if timeLeft == 0 {  // When timer hits 0:
                timer.invalidate()  // Stop timer
                endGame()           // Run end game code
            }
        }
    }
    // Called when time runs out
    func endGame() {
        running = false    // Stop game
        
        // Update high score if new score is bigger
        if score > highScore {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "HighScore")
            // Saves high score to the device
        }
        showAlert = true   // Show “Time's Up!” popup
    }
    // Reset game to beginning state
    func reset() {
        score = 0
        timeLeft = 20
        running = false
        
        // Reset cookie back to center
        xPos = 200
        yPos = 400
    }
}
#Preview {
    ContentView()
}
