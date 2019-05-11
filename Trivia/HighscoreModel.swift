//
//  PlayerItem.swift
//  Trivia
//
//  Created by Thomas on 04/05/2019.
//  Copyright © 2019 Thomas Hamburger. All rights reserved.
//

import Foundation

// Wordt gebruikt om een enkele score van een enkele speler op te slaan.
struct HighscoreModel: Codable {
    let name: String
    var score: String
}
