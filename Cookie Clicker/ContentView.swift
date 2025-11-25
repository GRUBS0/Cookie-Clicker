//
//  ContentView.swift
//  Cookie Clicker
//
//  Created by joseph phillips on 11/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var score = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Image("cookie")
                .resizable()
                .frame(width: 100, height: 100)
            
            Text("Score: \(score)")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            Button("Tap Me!") {
                score += 1
            }
            .font(.title)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    ContentView()
}
