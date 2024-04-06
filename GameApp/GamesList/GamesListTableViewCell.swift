//
//  GamesListTableViewCell.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 30/03/24.
//

import UIKit

protocol GameCellDelegate: AnyObject {
    func didTapFavoriteButton(at indexPath: IndexPath)
}

class GamesListTableViewCell: UITableViewCell {
    weak var delegate: GameCellDelegate?
    var indexPath: IndexPath!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func didTpFavoriteButton(_ sender: Any) {
        delegate?.didTapFavoriteButton(at: indexPath)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup() {
        thumbImageView.layer.cornerRadius = 8
        thumbImageView.layer.masksToBounds = true
    }
    
}
