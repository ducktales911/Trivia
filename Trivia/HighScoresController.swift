//
//  HighScoresController.swift
//  Trivia
//
//  Created by Thomas on 04/05/2019.
//  Copyright © 2019 Thomas Hamburger. All rights reserved.
//

import Foundation

struct HighScoresController {

    func fetchItems(completion: @escaping ([HighscoreModel]?) -> Void) {

        let url = URL(string: "https://ide50-thomashb.legacy.cs50.io:8080/list")!

        // Ontvang de JSON data, decodeer data en plaats data in een array van HighscoreModel objecten.
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let scoreItems = try? jsonDecoder.decode([HighscoreModel].self, from: data) {
                completion(scoreItems)
                print(scoreItems)
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
                return
            }
        }
        task.resume()
    }

    // Voer POST request uit met de naam en score uit een HighscoreModel object als query.
    func postItem(player: HighscoreModel) {

        let url = URL(string: "https://ide50-thomashb.legacy.cs50.io:8080/list")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postQuery = "name=\(player.name)&score=\(player.score)"
        request.httpBody = postQuery.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(String(bytes: data!, encoding: .utf8)!)
        }

        task.resume()
    }
}
