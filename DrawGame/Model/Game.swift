import Foundation

struct Game: DataModel {
    let id: String
    let playerAId: String
    let playerBId: String?
    let drawing: Drawing
    let isPlayerATurn: Bool
    let playerAScore: Int
    let playerBScore: Int
}

extension Game {
    enum CodingKeys: String, CodingKey {
        case id
        case playerAId
        case playerBId
        case drawing
        case isPlayerATurn
        case playerAScore
        case playerBScore
    }
}

extension Game {
    var isMyTurn: Bool {
        let myId = Api.udid
        
        if myId == playerAId {
            return isPlayerATurn
        } else if let playerBId = playerBId, playerBId == myId {
            return !isPlayerATurn
        }
        
        return false
    }
    
    var myScore: Int {
        let myId = Api.udid
        
        if myId == playerAId {
            return playerAScore
        } else {
            return playerBScore
        }
    }
    
    var otherScore: Int {
        let myId = Api.udid
        
        if myId == playerAId {
            return playerBScore
        } else {
            return playerAScore
        }
    }
}

