//
//  Movie.swift
//  TubiMovies
//
//  Created by Ganesan, Veeramani on 7/18/22.
//

import Foundation

typealias Movies = [Movie]

struct Movie: Codable {
    let id, title: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case image
    }
}
