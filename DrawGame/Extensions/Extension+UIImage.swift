//
//  Extension+UIImage.swift
//  DrawGame

import UIKit

extension UIImage {
    
    func getPixelRows() -> [PixelRow]? {
        // 1. Get pixels of image
        guard let inputCGImage = self.cgImage else { return nil }
        let width = inputCGImage.width
        let height = inputCGImage.height
        
        let bytesPerPixel: Int = 4
        let bytesPerRow: Int = bytesPerPixel * width
        let bitsPerComponent = 8
        
        var pixels = [UInt32](repeating: 0, count: width * height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        let context = CGContext(data: &pixels, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
        
        context?.draw(inputCGImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        // 2. Map color to brightness
        let pixelArray = pixels.map { color -> Pixel in
            let r = red(color)
            let g = green(color)
            let b = blue(color)

            return Pixel(r: Int(r), g: Int(g), b: Int(b))
        }
        
        return pixelRows(fromArray: pixelArray, width: width, height: height)
    }
    
    private func pixelRows(fromArray array: [Pixel], width: Int,height: Int) -> [PixelRow]? {
        guard width * height == array.count else { return nil }

        var pixelRows = [PixelRow]()
        var index = 0
        for _ in 0..<height {
            var pixels = [Pixel]()
            for _ in 0..<width {
                pixels.append(array[index])
                index += 1
            }
            pixelRows.append(PixelRow(pixels: pixels))
        }

        return pixelRows
    }
    
    // MARK: Bitmask helper methods
    
    private func mask8(_ x: UInt32) -> UInt32 {
        return (x) & 0xFF
    }
    
    private func red(_ r: UInt32) -> UInt32 {
        return mask8(r)
    }
    
    private func green(_ g: UInt32) -> UInt32 {
        return mask8(g >> 8)
    }
    
    private func blue(_ b: UInt32) -> UInt32 {
        return mask8(b >> 16)
    }
    
}
