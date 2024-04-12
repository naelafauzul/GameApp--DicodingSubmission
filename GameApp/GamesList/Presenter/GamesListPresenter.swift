//
//  GamesListPresenter.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 12/04/24.
//

import Foundation
import RxSwift

protocol GamesListPresenter {
    func loadLatestGames()
    func numberOfGames() -> Int
    func gameName(at index:Int) -> String
    func gameRating(at index: Int) -> String
    func gameDate(at index: Int) -> String
    func gameImage(at index: Int) -> String
    func toogleFavorite(at index: Int)
    func isFavorited(at index: Int) -> Bool
    func selectGame(at index: Int)
}

class DefaultGamesListPresenter: GamesListPresenter {
    
    private weak var view: GamesListView?
    private let interactor: GamesListInteractor
    private let router: GamesListRouter
    
    private let disposeBag = DisposeBag()
    private var games: [Game] = []
    
    init(view: GamesListView? = nil, interactor: GamesListInteractor, router: GamesListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func loadLatestGames() {
        interactor.loadLatestGames()
            .subscribe(onNext: { [weak self] games in
                self?.games = games
                self?.view?.reloadData()
            }, onError: { error in
            }).disposed(by: disposeBag)
    }
    
    func numberOfGames() -> Int {
        return games.count
    }
    
    func gameName(at index: Int) -> String {
        return games[index].name
    }
    
    func gameRating(at index: Int) -> String {
        return String(games[index].rating)
    }
    
    func gameImage(at index: Int) -> String {
        return games[index].backgroundImage
    }
    
    func gameDate(at index: Int) -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MM-yyyy"
        
        if let date = inputFormatter.date(from: games[index].released) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    func toogleFavorite(at index: Int) {
        let game = games[index]
        if isFavorited(at: index) {
            interactor.removeFavorite(gameId: game.id)
        } else {
            interactor.addFavorite(game: game)
        }
    }
    
    func isFavorited(at index: Int) -> Bool {
        let game = games[index]
        return interactor.isFavorited(gameId: game.id)
    }
    
    func selectGame(at index: Int) {
        router.showGameDetail(game: games[index])
    }
}
