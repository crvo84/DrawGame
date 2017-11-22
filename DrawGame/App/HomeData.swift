import Foundation

class HomeData {
    
    fileprivate(set) var myTurnGames = [Game]()
    fileprivate(set) var notMyTurnGames = [Game]()
    
    func reload(completion: @escaping () -> ()) {
        var myTurnGames = [Game]()
        for _ in 0..<5 {
            myTurnGames.append(Game.forTest(type: .beingCreatedByMe))
            myTurnGames.append(Game.forTest(type: .myTurnToGuess(iAmPlayerA: true)))
            myTurnGames.append(Game.forTest(type: .myTurnToGuess(iAmPlayerA: false)))
        }
        
        var notMyTurnGames = [Game]()
        for _ in 0..<5 {
            notMyTurnGames.append(Game.forTest(type: .justCreatedByMe))
            notMyTurnGames.append(Game.forTest(type: .notMyTurn(iAmPlayerA: true)))
            notMyTurnGames.append(Game.forTest(type: .notMyTurn(iAmPlayerA: false)))
        }
        
        self.myTurnGames = myTurnGames
        self.notMyTurnGames = notMyTurnGames
        completion()
        
//        Api.Games.getAll.getMultiple(type: Game.self) { [weak self] games in
//            self?.myTurnGames = games?.filter { $0.isMyTurn } ?? []
//            self?.notMyTurnGames = games?.filter { !$0.isMyTurn } ?? []
//            completion()
//        }
    }
}

// MARK: - For Testing
extension HomeData {
    
}
