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
    @State private var selectedAnswer: Int? = nil
    @State private var showResult = false
    @State private var isCorrect = false
    @State private var correctAnswerText = ""
    @State private var correctAnswersCount = 0
    @State private var showResultsView = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        if showResultsView {
            ResultsView(correctAnswers: correctAnswersCount, totalQuestions: quiz.questions.count)
        } else {
            let currentQuestion = quiz.questions[currentQuestionIndex]
            VStack {
                Text(currentQuestion.text)
                    .font(.title)
                    .padding()
                
                ForEach(0..<currentQuestion.answers.count, id: \.self) { index in
                    Button(action: {
                        selectedAnswer = index
                    }) {
                        HStack {
                            Text(currentQuestion.answers[index])
                                .foregroundColor(selectedAnswer == index ? .white : .blue)
                            Spacer()
                        }
                        .padding()
                        .background(selectedAnswer == index ? Color.blue : Color.clear)
                        .cornerRadius(8)
                    }
                    .disabled(showResult)
                }
                
                if showResult {
                    Text(isCorrect ? "Correct!" : "Incorrect. Correct answer: \(correctAnswerText)")
                        .padding()
                        .foregroundColor(isCorrect ? .green : .red)
                }
                
                Spacer()
                
                HStack {
                    Button("Home") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button(showResult ? "Next" : "OK") {
                        if showResult {
                            goToNextQuestion()
                        } else {
                            checkAnswer()
                        }
                    }
                    .padding()
                    .disabled(selectedAnswer == nil)
                }
            }
            .padding()
        }
    }
    
    private func checkAnswer() {
        guard let selectedAnswer = selectedAnswer else { return }
        let currentQuestion = quiz.questions[currentQuestionIndex]
        if let correctAnswerIndex = Int(currentQuestion.answer) {
            isCorrect = (selectedAnswer + 1) == correctAnswerIndex
            correctAnswerText = currentQuestion.answers[correctAnswerIndex - 1]
            if isCorrect {
                correctAnswersCount += 1
            }
            showResult = true
        }
    }
    
    private func goToNextQuestion() {
        showResult = false
        selectedAnswer = nil
        
        if currentQuestionIndex < quiz.questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            // Navigate to results view
            showResultsView = true
        }
    }
}
