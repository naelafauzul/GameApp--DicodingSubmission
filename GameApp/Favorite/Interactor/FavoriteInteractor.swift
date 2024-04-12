//
//  FavoriteInteractor.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 12/04/24.
//

import Foundation

protocol FavoriteInteractor {
    func loadFavorites() -> [Game]
    func removeFavorite(gameId: Int)
}

class DefaultFavoriteInteractor: FavoriteInteractor {
    private let coreDataService: CoreDataService
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    func loadFavorites() -> [Game] {
        return coreDataService.fetchFavorites()
    }
    
    func removeFavorite(gameId: Int) {
        coreDataService.removeFavorite(gameId: gameId)
    }
}
