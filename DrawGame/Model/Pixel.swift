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

extension Pixel {
    var pixelData: PixelData {
        return PixelData(a: 255,
                         r: UInt8(r),
                         g: UInt8(g),
                         b: UInt8(b))
    }
}

struct PixelData {
    var a: UInt8
    var r: UInt8
    var g: UInt8
    var b: UInt8
}
