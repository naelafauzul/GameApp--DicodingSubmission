//
//  CoreDataService.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 06/04/24.
//

import UIKit
import CoreData

class CoreDataService {
    static var shared: CoreDataService = CoreDataService()
    private init() {}
    
    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.context
    }
    
    func saveFavorite(game: Game) {
        let request = FavoriteGame.fetchRequest()
        request.predicate = NSPredicate(format: "gameId = \(game.id)")
        
        let favoriteGame: FavoriteGame
        if let data = try? context.fetch(request).first {
            favoriteGame = data
        } else {
            favoriteGame = FavoriteGame(context: context)
        }
        
        favoriteGame.gameId = Int64(game.id)
        favoriteGame.name = game.name
        favoriteGame.rating = game.rating
        favoriteGame.released = game.released
        favoriteGame.backgroundImage = game.backgroundImage
        favoriteGame.slug = game.slug
        favoriteGame.metacritic = Int64(game.metacritic)
        favoriteGame.platforms = game.platforms as NSObject
        favoriteGame.playTime = Int64(game.playtime)
        favoriteGame.suggestedCount = Int64(game.suggestionsCount)
        
        #if DEBUG
        try? context.save()
        #endif
        
    }
    
    func fetchFavorites() -> [Game] {
        let request = FavoriteGame.fetchRequest()
        let datas = (try? context.fetch(request)) ?? []
        
        return datas.compactMap { Game($0) }
 
    }
    
    func removeFavorite(gameId: Int) {
        let request = FavoriteGame.fetchRequest()
        request.predicate = NSPredicate(format: "gameId = \(gameId)")
        if let data = try? context.fetch(request).first {
            context.delete(data)
            
            #if DEBUG
            try? context.save()
            #endif
        }
    }
    
    func isFavorited(gameId: Int) -> Bool {
        let request = FavoriteGame.fetchRequest()
        request.predicate = NSPredicate(format: "gameId = \(gameId)")
        
        if let _ = try? context.fetch(request).first {
            return true
        } else {
            return false
        }
            
    }
}

