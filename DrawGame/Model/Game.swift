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








extension Game {
    enum TestGameType {
        case beingCreatedByMe
        case justCreatedByMe
        case myTurnToGuess(iAmPlayerA: Bool)
        case notMyTurn(iAmPlayerA: Bool)
    }
    
    static func forTest(type: TestGameType) -> Game {
        let width = 256
        let height = 256
        var pixels: [Pixel] = []
        for i in 0..<(width * height) {
            let isTop = i <= (width * height) / 2
            if isTop {
                pixels.append(Pixel(r: 0, g: 0, b: 255))
            } else {
                pixels.append(Pixel(r: 0, g: 255, b: 0))
            }
        }
        
        let playerAId: String
        let playerBId: String?
        let isPlayerATurn: Bool
        let playerAScore: Int
        let playerBScore: Int
        switch type {
        case .beingCreatedByMe: // my turn
            playerAId = Api.udid
            playerBId = nil
            isPlayerATurn = true
            playerAScore = 0
            playerBScore = 0
        case .justCreatedByMe: // not my turn
            playerAId = Api.udid
            playerBId = nil
            isPlayerATurn = false
            playerAScore = 0
            playerBScore = 0
        case .myTurnToGuess(let iAmPlayerA):
            playerAId = iAmPlayerA ? Api.udid : "otherUserId"
            playerBId = iAmPlayerA ? "otherUserId" : Api.udid
            isPlayerATurn = iAmPlayerA
            playerAScore = 2
            playerBScore = 2
        case .notMyTurn(let iAmPlayerA):
            playerAId = iAmPlayerA ? Api.udid : "otherUserId"
            playerBId = iAmPlayerA ? "otherUserId" : Api.udid
            isPlayerATurn = !iAmPlayerA
            playerAScore = 2
            playerBScore = 2
        }
        
        let drawing = Drawing(pixels: pixels, width: width, height: height, word: "house")
        let game = Game(id: "123", playerAId: playerAId, playerBId: playerBId, drawing: drawing, isPlayerATurn: isPlayerATurn, playerAScore: playerAScore, playerBScore: playerBScore)
        
        return game
    }
}

