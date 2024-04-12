//
//  FavoritePresenter.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 12/04/24.
//

import Foundation

protocol FavoritePresenter {
    func loadFavorites()
    func numberOfFavorites() -> Int
    func gameName(at index:Int) -> String
    func gameRating(at index: Int) -> String
    func gameDate(at index: Int) -> String
    func gameImage(at index: Int) -> String
    func removeFavorite(at index: Int)
    func selectFavorite(at index: Int)
}

class DefaultFavoritePresenter: FavoritePresenter {
    
    private weak var view: FavoriteView?
    private let interactor: FavoriteInteractor
    private let router: FavoriteRouter
    
    private var favorites: [Game] = []
    
    init(view: FavoriteView? = nil, interactor: FavoriteInteractor, router: FavoriteRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func loadFavorites() {
        favorites = interactor.loadFavorites()
        view?.reloadData()
    }
    
    func numberOfFavorites() -> Int {
        return favorites.count
    }
    
    func gameName(at index: Int) -> String {
        return favorites[index].name
    }
    
    func gameRating(at index: Int) -> String {
        return String(favorites[index].rating)
    }
    
    func gameDate(at index: Int) -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MM-yyyy"
        
        if let date = inputFormatter.date(from: favorites[index].released) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    
    func gameImage(at index: Int) -> String {
        return favorites[index].backgroundImage
    }
    
    func removeFavorite(at index: Int) {
        let favorite = favorites.remove(at: index)
        interactor.removeFavorite(gameId: favorite.id)
    }
    
    func selectFavorite(at index: Int) {
        router.showGameDetail(game: favorites[index])
    }
}

