//
//  MovieDetails.swift
//  TubiMovies
//
//  Created by Ganesan, Veeramani on 7/10/22.
//

import Foundation

struct MovieDetails: Codable {
    let id, title: String
    let image: String
    let index: UInt

    enum CodingKeys: String, CodingKey {
        case id, title
        case image
        case index
    }
}
