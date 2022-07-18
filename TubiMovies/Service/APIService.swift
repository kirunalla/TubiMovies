//
//  APIService.swift
//  TubiMovies
//
//  Created by Ganesan, Veeramani on 7/10/22.
//

import Foundation

struct APIService {
    
    private static let baseUrl = "https://us-central1-modern-venture-600.cloudfunctions.net/"
    private static let moviesAPI = "/api/movies/"
    
    enum APIServiceError: Error {
        case invalidURL
    }
    
    static func getMoviesList() async throws -> Movies {
        guard let url = URL(string: (baseUrl + moviesAPI)) else {
            throw APIServiceError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
        
        let movies = try JSONDecoder().decode(Movies.self, from: data)
        return movies
    }
    
    static func getMovieDetails(id: String) async throws -> MovieDetails {
        guard let url = URL(string: (baseUrl + moviesAPI + id)) else {
            throw APIServiceError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
        
        let movieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
        return movieDetails
    }
}
