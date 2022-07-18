//
//  HomeMovieViewController.swift
//  TubiMovies
//
//  Created by Ganesan, Veeramani on 7/10/22.
//

import UIKit
import Combine

class HomeMovieViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var movieListTableView: UITableView!
    
    private var movieViewModel = MovieViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tubi Movies"
        setupMovieListTableView()
        bindToViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetail" {
            if let movieDetailsViewController = segue.destination as? MovieDetailViewController {
                let selIndexPath = movieListTableView.indexPathForSelectedRow!
                movieDetailsViewController.movieId = movieViewModel.movies[selIndexPath.row].id
            }
        }
    }
}

extension HomeMovieViewController {
    
    private func bindToViewModel() {
        showActivityIndicator(true)
        movieViewModel.fetchMovies()
        
        movieViewModel.$movies.dropFirst().receive(on: DispatchQueue.main)
        .sink { [weak self] movies in
            self?.updateUI(movies)
        }
        .store(in: &cancellables)
    }
    
    private func setupMovieListTableView() {
        movieListTableView.dataSource = self
        movieListTableView.rowHeight = 100
    }
    
    private func updateUI(_ movies: Movies) {
        if movies.count > 0 {
            movieListTableView.reloadData()
            showErrorMessage(false)
        }
        else {
            showErrorMessage(true)
        }
        showActivityIndicator(false)
    }
    
    private func showErrorMessage(_ on: Bool) {
        view.bringSubviewToFront(errorLabel)
        errorLabel.isHidden = !on
    }
    
    private func showActivityIndicator(_ on: Bool) {
        view.bringSubviewToFront(activityIndicator)
        on ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

extension HomeMovieViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell)!
        cell.updateData(with: self.movieViewModel.movies[indexPath.row])
        return cell
    }
}
