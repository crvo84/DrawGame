import Foundation

struct Drawing: DataModel {
    let pixels: [Pixel]
    let width: Int
    let height: Int
    let word: String
}

extension Drawing {
    enum CodingKeys: String, CodingKey {
        case pixels
        case width
        case height
        case word
    }
}

extension Drawing {
    var image: UIImage? {
        
    }
}
