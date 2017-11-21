import Foundation

struct Drawing: DataModel {
    let pixelRows: [PixelRow]
    let word: String
}

extension Drawing {
    enum CodingKeys: String, CodingKey {
        case pixelRows
        case word
    }
}
