//
//  GamesListRouter.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 12/04/24.
//

import Foundation
import UIKit

protocol GamesListRouter {
    func create() -> UIViewController
    func showGameDetail(game: Game)
}

class DefaultGamesListRouter: GamesListRouter {
    private var navigationController: UINavigationController!
    
    func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "GamesList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GamesList") as! GamesListViewController
        
        let interactor = DefaultGamesListInteractor(coreDataService: CoreDataService.shared, apiService: ApiService.shared)
        let presenter = DefaultGamesListPresenter(view: viewController, interactor: interactor, router: self)
        
        viewController.presenter = presenter
        
        self.navigationController = UINavigationController(rootViewController: viewController)
        
        return self.navigationController
    }
    
    func showGameDetail(game: Game) {
        let storyboard = UIStoryboard(name: "GameDetil", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                
        viewController.selectedGames = game

        navigationController.pushViewController(viewController, animated: true)
    }
}
