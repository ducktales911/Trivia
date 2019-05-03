//
//  URL+Helpers.swift
//  Trivia
//
//  Created by Thomas on 02/05/2019.
//  Copyright © 2019 Thomas Hamburger. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem.init(name: $0.0, value: $0.1) }
        return components?.url
    }
}
