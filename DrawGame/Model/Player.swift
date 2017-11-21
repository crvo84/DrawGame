import Foundation

struct Player: DataModel {
    let id: String
    let games: [Game]
}

extension Player {
    enum CodingKeys: String, CodingKey {
        case id
        case games
    }
}

