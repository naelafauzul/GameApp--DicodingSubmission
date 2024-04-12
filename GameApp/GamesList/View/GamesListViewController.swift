//
//  GamesListViewController.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 30/03/24.
//

import UIKit
import Kingfisher

protocol GamesListView: AnyObject{
    func reloadData()
}

class GamesListViewController: UIViewController, GamesListView {
    func reloadData() {
        tableView.reloadData()
    }
    
    @IBOutlet weak var aboutButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var presenter: GamesListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadLatestGames()
        
        aboutButton.target = self
        aboutButton.action = #selector(aboutButtonTapped)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup(){
        title = "Games"
        
        tableView.register(UINib(nibName: "GamesViewCell", bundle: nil), forCellReuseIdentifier: "GamesListCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadLatestGames(){
        presenter.loadLatestGames()
    }
    
    @objc func aboutButtonTapped() {
        let storyboard = UIStoryboard(name: "About", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        
        
        navigationController?.pushViewController(viewController, animated: true)  
    }
}

extension GamesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfGames()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GamesListCell", for: indexPath) as! GamesListTableViewCell
        
        cell.thumbImageView.kf.setImage(with: URL(string: presenter.gameImage(at: indexPath.row)))
        cell.titleLabel.text = presenter.gameName(at: indexPath.row)
        cell.ratingLabel.text = presenter.gameRating(at: indexPath.row)
        cell.dateLabel.text = presenter.gameDate(at: indexPath.row)
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
}

extension GamesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectGame(at: indexPath.row)
    }
}

extension GamesListViewController: GameCellDelegate {
    func GameListTableViewCellFavoriteButton(_ cell: GamesListTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            presenter.toogleFavorite(at: indexPath.row)
            let image = presenter.isFavorited(at: indexPath.row)
            ? UIImage(systemName: "heart.fill")
            : UIImage(systemName: "heart")
            
            cell.favoriteButton.setImage(image, for: .normal)
        }
    }
}
