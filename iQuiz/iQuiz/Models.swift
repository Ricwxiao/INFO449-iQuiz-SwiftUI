//
//  Model.swift
//  iQuiz
//
//  Created by Ricwxiao on 2024/5/19.
//

import Foundation

struct Quiz: Codable {
    let title: String
    let desc: String
    let icon: String?
    let questions: [Question]
}

struct Question: Codable {
    let text: String
    let answer: String
    let answers: [String]
}
