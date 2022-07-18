//
//  MovieViewModel.swift
//  TubiMovies
//
//  Created by Ganesan, Veeramani on 7/10/22.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var movies: Movies = []
    
    func fetchMovies() {
        Task {
            do {
                self.movies = try await APIService.getMoviesList()
            } catch {
                self.movies = []
                print ("Failed to Fetch Movies List")
            }
        }
    }
}
