//
//  TriviaController.swift
//  Trivia
//
//  Created by Thomas on 24/04/2019.
//  Copyright © 2019 Thomas Hamburger. All rights reserved.
//

import Foundation
import HTMLString

struct TriviaController {
    
    func fetchItems(matching query: [String: String], completion: @escaping ([QuestionModel]?) -> Void) {
        
        let baseURL = URL(string: "https://opentdb.com/api.php?")!
        
        guard let url = baseURL.withQueries(query) else {
            completion(nil)
            print("Generating URL with supplied queries failed.")
            return
        }        
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let questionitems = try? jsonDecoder.decode(QuestionList.self, from: data) {
                completion(questionitems.results)
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
                return
            }
        }
        task.resume()
    }
}


