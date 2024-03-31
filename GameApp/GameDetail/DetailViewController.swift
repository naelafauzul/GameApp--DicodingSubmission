//
//  DetailViewController.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 30/03/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var selectedGames: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    
    
    func setup() {
        if let games = selectedGames {
            nameLabel.text = games.name
            ratingLabel.text = (String(games.rating))
            dateLabel.text = "Released: \(games.formattedReleasedDate())"
            
            if let imageUrl = URL(string: games.backgroundImage) {
                ApiService.shared.downloadImage(from: imageUrl) { result in
                    DispatchQueue.main.async {
                        switch result{
                        case .success(let image):
                            self.thumbImageView.image = image
                        case .failure:
                            self.thumbImageView.image = nil
                        }
                    }
                }
            }
        }
    }
    
    
}
