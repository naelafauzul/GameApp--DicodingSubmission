//
//  AboutViewController.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 31/03/24.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "Naela Fauzul Muna || Informatika 2021"
        photo.layer.cornerRadius = photo.bounds.width / 2
        photo.layer.masksToBounds = true
        
    }
}
