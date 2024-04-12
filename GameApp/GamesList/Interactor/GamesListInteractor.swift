//
//  GamesListInteractor.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 12/04/24.
//

import Foundation
import RxSwift

protocol GamesListInteractor {
    func loadLatestGames() -> Observable<[Game]>
    func addFavorite(game: Game)
    func removeFavorite(gameId: Int)
    func isFavorited(gameId: Int) -> Bool
}

class DefaultGamesListInteractor : GamesListInteractor {
    
    private let coreDataService: CoreDataService
    private let apiService: ApiService
    private let disposeBag = DisposeBag()
    
    init(coreDataService: CoreDataService, apiService: ApiService) {
        self.coreDataService = coreDataService
        self.apiService = apiService
    }
    
    func addFavorite(game: Game) {
        coreDataService.saveFavorite(game: game)
    }
    
    func removeFavorite(gameId: Int) {
        coreDataService.removeFavorite(gameId: gameId)
    }
    
    func isFavorited(gameId: Int) -> Bool {
        return coreDataService.isFavorited(gameId: gameId)
    }
    
    func loadLatestGames() -> Observable<[Game]> {
        return apiService.loadLatestGames()
    }
}
