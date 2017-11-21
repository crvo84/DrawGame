import Foundation

struct Pixel: DataModel {
    let r: Int
    let g: Int
    let b: Int
}

extension Pixel {
    enum CodingKeys: String, CodingKey {
        case r
        case g
        case b
    }
}
