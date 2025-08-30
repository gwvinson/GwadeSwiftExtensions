//
//  UIImage.swift
//  Path
//
//  Created by Garret Vinson on 2/8/24.
//

import SwiftUI
import UIKit

extension UIImage {
    
    public func fixOrientation() -> UIImage {
        
        guard let cgImage = cgImage else { return self }
        
        if imageOrientation == .up { return self }
        
        var transform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi/2))
            
        case .up, .upMirrored:
            break
            
        default:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .up, .down, .left, .right:
            break
            
        default:
            break
        }
        
        if let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
            
            ctx.concatenate(transform)
            
            switch imageOrientation {
                
            case .left, .leftMirrored, .right, .rightMirrored:
                ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
                
            default:
                ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            }
            
            if let finalImage = ctx.makeImage() {
                return (UIImage(cgImage: finalImage))
            }
        }
        
        // something failed -- return original
        return self
    }
    
    
    //MARK: Resizing

    /// Create a UIImage thumbnail from ImageData with a specified maxPixlSize.
    public static func getThumbnail(imageData: Data, maxPixelSize: Int) -> UIImage? {
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize] as CFDictionary

        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
        guard let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options) else { return nil }

        return UIImage(cgImage: imageReference)
      }
    
    /// Asynchronously create a UIImage thumbnail from ImageData with a specified maxPixlSize.
    public static func getThumbnail(imageData: Data, maxPixelSize: Int) async -> UIImage? {
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize] as CFDictionary

        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
        guard let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options) else { return nil }

        return UIImage(cgImage: imageReference)
    }
    
    /// Asynchronously create a UIImage thumbnail from ImageData with a specified maxPixlSize and return
    /// the image along with the new thumbnail image data.
    public static func getThumbnail(imageData: Data, maxPixelSize: Int) async -> (image: UIImage, data: Data)? {
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize] as CFDictionary

        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
        guard let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options) else { return nil }

        let image = UIImage(cgImage: imageReference)
        guard let data = image.jpegData(compressionQuality: 1) else {
            #if DEBUG
                print("Failed to get image.jpegData.")
            #endif
            return nil
        }
        return (image: image, data: data)
    }
    
    public static func buildUIImage(data: Data) async -> UIImage {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil),
              let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, nil)
        else { return UIImage() }
        return UIImage(cgImage: imageReference)
    }
    
    /// Compress a UIImage to a max size in MB.
    public static func compressImage(_ image: UIImage, toMaxSize maxSizeMB: Double) async -> Data? {
        let maxSizeBytes = Int(maxSizeMB * 1024 * 1024)
        var minQuality: CGFloat = 0.0
        var maxQuality: CGFloat = 1.0
        var midQuality: CGFloat = 1.0
        var compressedData: Data?

        while minQuality <= maxQuality {
            midQuality = (minQuality + maxQuality) / 2
            if let data = image.jpegData(compressionQuality: midQuality) {
                if data.count < maxSizeBytes {
                    compressedData = data
                    minQuality = midQuality + 0.01
                } else {
                    maxQuality = midQuality - 0.01
                }
            } else {
                // Attempt to return the last compression.
                // Finally attempt to return the images jpegData at max quality.
                #if DEBUG
                    print("returning from compression early.")
                #endif
                return compressedData ?? image.jpegData(compressionQuality: 1)
            }
        }
        return compressedData
    }
}

extension UIImage: @retroactive NSDiscardableContent {
    public func beginContentAccess() -> Bool {
        return true
    }
    
    public func endContentAccess() {
        //Do nothing
    }
    
    public func discardContentIfPossible() {
        //Do Nothing
    }
    
    public func isContentDiscarded() -> Bool {
        return false
    }
}

extension UIImage: @retroactive Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .jpeg) { image in
            if let jpgData = image.jpegData(compressionQuality: 1) {
                return jpgData
            } else {
                // Handle the case where UIImage could not be converted to jpg.
                throw ImageConversionError.failedToConvertToJPG
            }
        }
    }
    
    public enum ImageConversionError: Error {
        case failedToConvertToJPG
    }
}
