//
//  ResultsView.swift
//  iQuiz
//
//  Created by Ricwxiao on 2024/5/19.
//

import SwiftUI

struct ResultsView: View {
    let correctAnswers: Int
    let totalQuestions: Int
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Quiz Finished!")
                .font(.largeTitle)
                .padding()
            
            Text("You got \(correctAnswers) out of \(totalQuestions) correct.")
                .font(.title2)
                .padding()
            
            Spacer()
            
            Button("Home") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .padding()
    }
}
