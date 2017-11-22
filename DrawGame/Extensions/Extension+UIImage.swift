//
//  Extension+UIImage.swift
//  DrawGame

import UIKit

extension UIImage {
    
    // MARK: - UIImage -> Drawing
    
    func getDrawing(withWord word: String) -> Drawing? {
        guard let pixels = getPixels() else { return nil }
        
        let size = self.size
        return Drawing(pixels: pixels,
                       width: Int(size.width),
                       height: Int(size.height),
                       word: word)
    }
    
    // MARK: - UIImage -> Pixels
    
    func getPixels() -> [Pixel]? {
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
        let result = pixels.map { color -> Pixel in
            let r = red(color)
            let g = green(color)
            let b = blue(color)

            return Pixel(r: Int(r), g: Int(g), b: Int(b))
        }
        
        return result
    }
    
    // MARK: - Pixels -> UIImage
    
    static func from(pixels: [PixelData], width: Int, height: Int) -> UIImage? {
        guard pixels.count == width * height else { return nil } // invalid params
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo:CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        var data = pixels
        let pixelDataSize = MemoryLayout<PixelData>.size
        guard let providerRef = CGDataProvider(data: NSData(bytes: &data, length: data.count * pixelDataSize)) else { return nil }

        guard let cgImage = CGImage(width: width, height: height, bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerPixel, bytesPerRow: width * pixelDataSize, space: rgbColorSpace, bitmapInfo: bitmapInfo, provider: providerRef, decode: nil, shouldInterpolate: true, intent: .defaultIntent) else { return nil }
        
        return UIImage(cgImage: cgImage)
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
