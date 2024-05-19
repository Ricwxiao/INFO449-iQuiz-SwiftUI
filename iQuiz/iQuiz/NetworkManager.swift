//
//  NetworkManager.swift
//  iQuiz
//
//  Created by Ricwxiao on 2024/5/19.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    @Published var quizzes: [Quiz] = []
    @Published var showError = false
    
    let defaultURL = "http://tednewardsandbox.site44.com/questions.json"
    
    func fetchQuizzes(from urlString: String? = nil) {
        guard let url = URL(string: urlString ?? defaultURL) else {
            showError = true
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedQuizzes = try JSONDecoder().decode([Quiz].self, from: data)
                    DispatchQueue.main.async {
                        self.quizzes = decodedQuizzes
                        self.saveQuizzesToUserDefaults(quizzes: decodedQuizzes)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showError = true
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showError = true
                }
            }
        }.resume()
    }
    
    func saveQuizzesToUserDefaults(quizzes: [Quiz]) {
        if let encodedQuizzes = try? JSONEncoder().encode(quizzes) {
            UserDefaults.standard.set(encodedQuizzes, forKey: "quizzes")
        }
    }
    
    func loadQuizzesFromUserDefaults() {
        if let savedQuizzes = UserDefaults.standard.data(forKey: "quizzes"),
           let decodedQuizzes = try? JSONDecoder().decode([Quiz].self, from: savedQuizzes) {
            quizzes = decodedQuizzes
        }
    }
}
