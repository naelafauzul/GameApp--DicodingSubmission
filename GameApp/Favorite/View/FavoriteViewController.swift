//
//  FavoriteViewController.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 06/04/24.
//

import UIKit

protocol FavoriteView: AnyObject {
    func reloadData()
}

class FavoriteViewController: UIViewController, FavoriteView {
    func reloadData() {
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: FavoritePresenter!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadFavorites()
    }
    
    func setup() {
        title = "Favorites"
        tableView.register(UINib(nibName: "GamesViewCell", bundle: nil), forCellReuseIdentifier: "GamesListCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadFavorites() {
        presenter.loadFavorites()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfFavorites()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GamesListCell", for: indexPath) as! GamesListTableViewCell
        
        cell.thumbImageView.kf.setImage(with: URL(string: presenter.gameImage(at: indexPath.row)))
        cell.titleLabel.text = presenter.gameName(at: indexPath.row)
        cell.ratingLabel.text = presenter.gameRating(at: indexPath.row)
        cell.dateLabel.text = presenter.gameDate(at: indexPath.row)
        cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.selectFavorite(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let detele = UIContextualAction(style: .destructive, title: "Remove") { _, _, completion in
            self.presenter.removeFavorite(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        detele.image = UIImage(systemName: "trash")
        
        let actions = [
            detele
        ]
        
        return UISwipeActionsConfiguration(actions: actions)
    }
}

