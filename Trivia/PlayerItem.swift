//
//  PlayerItem.swift
//  Trivia
//
//  Created by Thomas on 04/05/2019.
//  Copyright © 2019 Thomas Hamburger. All rights reserved.
//

import Foundation

struct PlayerItem: Codable {
    var name: String
    var score: String
}

struct PlayerItems: Codable {
    let results: [PlayerItem]
}
