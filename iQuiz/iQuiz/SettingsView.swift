//
//  SettingsView.swift
//  iQuiz
//
//  Created by Ricwxiao on 2024/5/19.
//

import SwiftUI

struct SettingsView: View {
    @State private var urlString: String = ""
    @EnvironmentObject var networkManager: NetworkManager
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Data Source")) {
                    TextField("Enter URL", text: $urlString)
                    Button("Check Now") {
                        networkManager.fetchQuizzes(from: urlString)
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                urlString = UserDefaults.standard.string(forKey: "quizURL") ?? networkManager.defaultURL
            }
            .onDisappear {
                UserDefaults.standard.set(urlString, forKey: "quizURL")
            }
            .alert(isPresented: $networkManager.showError) {
                Alert(title: Text("Error"), message: Text("Unable to fetch data"), dismissButton: .default(Text("OK")))
            }
        }
    }
}
