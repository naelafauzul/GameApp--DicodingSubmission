//
//  FavoriteRouter.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 12/04/24.
//

import Foundation
import UIKit

protocol FavoriteRouter {
    func create() -> UIViewController
    func showGameDetail(game: Game)
}

class DefaultFavoriteRouter: FavoriteRouter {
    private var navigationController: UINavigationController!
    
    func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "Favorite", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        
        let interactor = DefaultFavoriteInteractor(coreDataService: CoreDataService.shared)
        let presenter = DefaultFavoritePresenter(view: viewController, interactor: interactor, router: self)
        
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
