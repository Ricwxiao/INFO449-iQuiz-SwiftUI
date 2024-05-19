//
//  ResultsView.swift
//  iQuiz
//
//  Created by Ricwxiao on 2024/5/19.
//

import SwiftUI

struct ResultsView: View {
    let score: Int
    let total: Int

    var body: some View {
        VStack {
            Text("Quiz Finished!")
                .font(.largeTitle)
                .padding()
            Text("You scored \(score) out of \(total)")
                .font(.headline)
            Button(action: {
                // Navigate back to the home screen
            }) {
                Text("Home")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
        }
    }
}
