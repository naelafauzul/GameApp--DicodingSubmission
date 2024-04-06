//
//  GamesListViewController.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 30/03/24.
//

import UIKit

class GamesListViewController: UIViewController {
    @IBOutlet weak var aboutButton: UIBarButtonItem!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var latestGamesList: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Games"
        setup()

        aboutButton.target = self
        aboutButton.action = #selector(aboutButtonTapped)
        
        favoriteButton.target = self
        favoriteButton.action = #selector(favoriteButtonTapped)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup(){
        loadLatestGames()
        tableView.register(UINib(nibName: "GamesViewCell", bundle: nil), forCellReuseIdentifier: "GamesListCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadLatestGames(){
        ApiService.shared.loadLatestGames{ result in
            switch result {
            case.success(let gamesList):
                self.latestGamesList = gamesList
                self.tableView.reloadData()
                print("Response berhasil: \(gamesList)")
            case .failure(let error):
                print("Gagal memuat data: \(error)")
            }
            
        }
    }
    
    @objc func aboutButtonTapped() {
        let storyboard = UIStoryboard(name: "About", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        
        navigationController?.pushViewController(viewController, animated: true)
  
    }
    
    @objc func favoriteButtonTapped() {
        let storyboard = UIStoryboard(name: "Favorite", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        
        navigationController?.pushViewController(viewController, animated: true)
  
    }
}

extension GamesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestGamesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GamesListCell", for: indexPath) as! GamesListTableViewCell
        
        let games = latestGamesList[indexPath.row]
        cell.titleLabel.text = games.name
        cell.ratingLabel.text = String(games.rating)
        cell.dateLabel.text = games.formattedReleasedDate()
        
        let isFavorited = CoreDataService.shared.isFavorited(gameId: games.id)
            cell.favoriteButton.setImage(UIImage(systemName: isFavorited ? "heart.fill" : "heart"), for: .normal)
        
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
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
}

extension GamesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let games = latestGamesList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "GameDetil", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        viewController.selectedGames = games
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension GamesListViewController: GameCellDelegate {
    func didTapFavoriteButton(at indexPath: IndexPath) {
        let game = latestGamesList[indexPath.row]

        if CoreDataService.shared.isFavorited(gameId: game.id) {
            CoreDataService.shared.deleteFavorite(gameId: game.id)

            if let cell = tableView.cellForRow(at: indexPath) as? GamesListTableViewCell {
                cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                showAlert(title: "Favorite removed", message: "Game removed from favorites")
            }
        } else {
            CoreDataService.shared.saveFavorite(game: game)

            if let cell = tableView.cellForRow(at: indexPath) as? GamesListTableViewCell {
                cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                showAlert(title: "Favorite Added", message: "Game added to favorites")
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
