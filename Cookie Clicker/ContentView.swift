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
        }
    }
}
