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
    @IBOutlet weak var playTime: UILabel!
    @IBOutlet weak var suggestion: UILabel!
    @IBOutlet weak var metacritic: UILabel!
    @IBOutlet weak var minimumReq: UILabel!
    @IBOutlet weak var minimum: UILabel!
    @IBOutlet weak var tools: UILabel!
    
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
            playTime.text = "Playtime: \(String(games.playtime))"
            suggestion.text = "Suggestions: \(String(games.suggestionsCount))"
            metacritic.text = "Metacritic: \(String(games.metacritic))"
            minimumReq.text = "Minimum Requirement"
            thumbImageView.kf.setImage(with: URL(string: games.backgroundImage))
            
            if let platform = games.platforms.first {
                if let minimumRequirement = platform.requirements_en?.minimum {
                    minimum.text = minimumRequirement
                } else {
                    minimum.text = "There's no minimum requirements."
                }
                
    
                if let toolsPlatform = platform.platform {
                    tools.text = toolsPlatform.name
                } else {
                    tools.text = "No Tools"
                }
            }
            
            
        }
    }
}
