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

