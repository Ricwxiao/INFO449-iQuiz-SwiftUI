//
//  ContentView.swift
//  iQuiz
//
//  Created by Ricwxiao on 2024/5/18.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var networkManager = NetworkManager()
    @State private var showSettings = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(networkManager.quizzes, id: \.title) { quiz in
                    NavigationLink(destination: QuizView(quiz: quiz)) {
                        HStack {
                            Image(systemName: quiz.icon ?? "default-icon")
                                .resizable()
                                .frame(width: 40, height: 40)
                            VStack(alignment: .leading) {
                                Text(quiz.title)
                                    .font(.headline)
                                Text(quiz.desc)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Quiz Topics")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView().environmentObject(networkManager)
            }
            .onAppear {
                networkManager.loadQuizzesFromUserDefaults()
                networkManager.fetchQuizzes()
            }
        }
    }
}


#Preview {
    ContentView()
}
