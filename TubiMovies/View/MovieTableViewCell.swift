//
//  MovieTableViewCell.swift
//  TubiMovies
//
//  Created by Ganesan, Veeramani on 7/10/22.
//

import UIKit
import SDWebImage

/// Custom Tableview cell to display the title, director and description, when tapped, of each movie
class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCellId"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    func updateData(with movie: Movie) {
        let boldTitle = NSAttributedString(string: movie.title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)])
        titleLabel.attributedText = boldTitle
        thumbImageView.sd_setImage(with: URL(string: movie.image), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
