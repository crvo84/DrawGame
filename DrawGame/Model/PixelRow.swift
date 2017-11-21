import Foundation

struct PixelRow: DataModel {
    let pixels: [Pixel]
}

extension PixelRow {
    enum CodingKeys: String, CodingKey {
        case pixels
    }
}

