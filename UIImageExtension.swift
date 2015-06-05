//
//  UIImageExtension.swift
//  Euterpe
//
//  Created by Andrew Breckenridge on 6/4/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

typealias lolXcodeSux = CIImage // Xcode has a compiler bug with CIImage's in extensions

extension UIImage {
    func fixOrientation() -> UIImage {
        return self
    }
    
    func colorInverted() -> UIImage {
        let cIImage =  lolXcodeSux(CGImage: self.CGImage)
        var invertFilter = CIFilter(name: "CIColorInvert")
        cIImage.setValue(invertFilter, forKey: kCIInputImageKey)
        
        let cIOutputImage = invertFilter.outputImage
        
        let ciContext = CIContext(options:[kCIContextUseSoftwareRenderer: true])
        let cgOutputImage = ciContext.createCGImage(cIOutputImage, fromRect: cIOutputImage.extent())
        
        return UIImage(CGImage: cgOutputImage, scale: 1, orientation: .Up)!
    }
}
