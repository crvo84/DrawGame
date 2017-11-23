import Foundation

class HomeData {
    
    fileprivate(set) var myTurnGames = [Game]()
    fileprivate(set) var notMyTurnGames = [Game]()
    
    func reload(completion: @escaping () -> ()) {
        Api.Games.getAll.getMultiple(type: Game.self) { [weak self] games in
            self?.myTurnGames = games?.filter { $0.isMyTurn } ?? []
            self?.notMyTurnGames = games?.filter { !$0.isMyTurn } ?? []
            completion()
        }
    }
    
    static func createGame(drawing: Drawing, completion: @escaping (Game?) -> ()) {
        Api.Games.create(drawing: drawing).getSingle(type: Game.self) { game in
            completion(game)
        }
    }
    
    static func findGame(completion: @escaping (Game?) -> ()) {
        Api.Games.getAvailable.getSingle(type: Game.self) { game in
            completion(game)
        }
    }
    
    static func endTurn(game: Game, answeredCorrectly: Bool, newDrawing: Drawing, completion: @escaping (Game?) -> ()) {
        Api.Games.endTurn(gameId: game.id, answeredCorrectly: answeredCorrectly, newDrawing: newDrawing)
        .getSingle(type: Game.self) { updatedGame in
            completion(updatedGame)
        }
    }
}

// MARK: - For Testing
extension HomeData {
    
}
