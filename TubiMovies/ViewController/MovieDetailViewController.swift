//
//  MovieDetailViewController.swift
//  TubiMovies
//
//  Created by Ganesan, Veeramani on 7/10/22.
//

import UIKit
import Combine
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    private var movieDetailsViewModel = MovieDetailsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    var movieId: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie Detail"
        bindToViewModel()
    }
    
    private func bindToViewModel() {
        guard let movieId = self.movieId else { return }
        
        movieDetailsViewModel.fetchMovieDetails(id: movieId)
        movieDetailsViewModel.$movieDetails.dropFirst()
        .receive(on: DispatchQueue.main)
        .sink { [weak self] movieDetails in
            if let movieDetails = movieDetails {
                self?.updateMovieDetails(movieDetails)
            }
        }
        .store(in: &cancellables)
    }
    
    private func updateMovieDetails(_ details: MovieDetails) {
        let boldTitle = NSAttributedString(string: details.title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)])
        titleLabel.attributedText = boldTitle
        
        let boldIndex = NSAttributedString(string: String(details.index), attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)])
        indexLabel.attributedText = boldIndex
        thumbImageView.sd_setImage(with: URL(string: details.image), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
