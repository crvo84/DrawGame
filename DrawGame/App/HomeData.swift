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
}

// MARK: - For Testing
extension HomeData {
    
}
