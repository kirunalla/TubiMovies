//
//  MovieDetailsViewModel.swift
//  TubiMovies
//
//  Created by Ganesan, Veeramani on 7/10/22.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    
    private static let cache: LRUCache<String, MovieDetails> = LRUCache(maxCapacity: 5)
    @Published var movieDetails: MovieDetails?
    
    func fetchMovieDetails(id: String) {
        Task {
            do {
                if MovieDetailsViewModel.cache.isValid(key: id) {
                    self.movieDetails = MovieDetailsViewModel.cache.get(key: id)
                }
                else {
                    let movieDetails = try await APIService.getMovieDetails(id: id)
                    MovieDetailsViewModel.cache.add(key: id, value: movieDetails)
                    self.movieDetails = movieDetails
                }
            } catch {
                self.movieDetails = nil
                print ("Failed to Fetch Movies Deatils")
            }
        }
    }
}
