import UIKit

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
        let pixelDataArray = pixels.map { $0.pixelData }
        return UIImage.from(pixels: pixelDataArray,
                            width: width, height: height)
    }
}
