//
//  GamesListViewController.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 30/03/24.
//

import UIKit

class GamesListViewController: UIViewController {
    @IBOutlet weak var aboutButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var latestGamesList: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "Games"
        setup()
        
        // Menambahkan aksi untuk tombol "About"
        aboutButton.target = self
        aboutButton.action = #selector(aboutButtonTapped)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup(){
        loadLatestGames()
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

extension GamesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let games = latestGamesList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "GameDetil", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        viewController.selectedGames = games
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
