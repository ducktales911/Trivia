//
//  QuestionItem.swift
//  Trivia
//
//  Created by Thomas on 02/05/2019.
//  Copyright © 2019 Thomas Hamburger. All rights reserved.
//

import Foundation

struct QuestionItem: Codable {
    
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    var category: String
    var difficulty: String
    var type: String

    enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
        case category
        case difficulty
        case type
    }
}

struct QuestionItems: Codable {
    let results: [QuestionItem]
}
