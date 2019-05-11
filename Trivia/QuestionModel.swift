//
//  QuestionModel.swift
//  Trivia
//
//  Created by Thomas on 02/05/2019.
//  Copyright © 2019 Thomas Hamburger. All rights reserved.
//

import Foundation

// Wordt gebruikt om een enkele alle attributen van een enkele vraag in op te slaan.
struct QuestionModel: Codable {

    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let category: String
    let difficulty: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
        case category
        case difficulty
        case type
    }
}

// Wordt gebruikt om alle QuestionModel objecten in op te slaan.
struct QuestionList: Codable {
    let results: [QuestionModel]
}
