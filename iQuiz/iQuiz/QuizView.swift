//
//  QuizView.swift
//  iQuiz
//
//  Created by Ricwxiao on 2024/5/19.
//

import SwiftUI

struct QuizView: View {
    let quiz: Quiz
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswerIndex: Int? = nil
    @State private var isAnswerSubmitted = false
    @State private var score = 0
    @State private var showResults = false

    var body: some View {
        VStack {
            if currentQuestionIndex < quiz.questions.count {
                let question = quiz.questions[currentQuestionIndex]
                Text(question.text)
                    .font(.title)
                    .padding()

                ForEach(0..<question.answers.count, id: \.self) { index in
                    Button(action: {
                        selectedAnswerIndex = index
                    }) {
                        Text(question.answers[index])
                            .padding()
                            .background(selectedAnswerIndex == index ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 5)
                }

                if isAnswerSubmitted {
                    Text(selectedAnswerIndex == quiz.questions[currentQuestionIndex].answers.firstIndex(of: quiz.questions[currentQuestionIndex].answer) ? "Correct!" : "Wrong!")
                        .font(.headline)
                        .foregroundColor(selectedAnswerIndex == quiz.questions[currentQuestionIndex].answers.firstIndex(of: quiz.questions[currentQuestionIndex].answer) ? .green : .red)
                }

                HStack {
                    Button(action: {
                        // Navigate back to the home screen
                    }) {
                        Text("Home")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        if let selectedAnswerIndex = selectedAnswerIndex {
                            if selectedAnswerIndex == quiz.questions[currentQuestionIndex].answers.firstIndex(of: quiz.questions[currentQuestionIndex].answer) {
                                score += 1
                            }
                            isAnswerSubmitted = true
                        }
                    }) {
                        Text("Submit")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .disabled(selectedAnswerIndex == nil)
                    }
                    .padding(.top)

                    if isAnswerSubmitted {
                        Button(action: {
                            currentQuestionIndex += 1
                            selectedAnswerIndex = nil
                            isAnswerSubmitted = false
                            if currentQuestionIndex == quiz.questions.count {
                                showResults = true
                            }
                        }) {
                            Text("Next")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.top)
                    }
                }
            } else {
                NavigationLink(destination: ResultsView(score: score, total: quiz.questions.count), isActive: $showResults) {
                    EmptyView()
                }
            }
        }
        .padding()
    }
}
