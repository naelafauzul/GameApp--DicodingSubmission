//
//  FavoriteViewController.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 06/04/24.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var latestGamesList: [Game] = []
    
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
        latestGamesList = CoreDataService.shared.fetchFavorites()
        tableView.reloadData()
    }
}



extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestGamesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GamesListCell", for: indexPath) as! GamesListTableViewCell
        
        let games = latestGamesList[indexPath.row]
        cell.titleLabel.text = games.name
        cell.ratingLabel.text = String(games.rating)
        cell.dateLabel.text = games.formattedReleasedDate()
        cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
        if let imageUrl = URL(string: games.backgroundImage) {
            ApiService.shared.downloadImage(from: imageUrl) { result in
                DispatchQueue.main.async {
                    switch result{
                    case .success(let image):
                        cell.thumbImageView.image = image
                    case .failure:
                        cell.thumbImageView.image = nil
                    }
                }
            }
        }
        
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let games = latestGamesList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "GameDetil", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        viewController.selectedGames = games
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let gameId = latestGamesList[indexPath.row].id
                CoreDataService.shared.deleteFavorite(gameId: gameId)
    
                latestGamesList.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .automatic)

                loadFavorites()
            }
        }
}

