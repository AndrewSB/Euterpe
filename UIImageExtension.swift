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
    
     func shrinkTo(height: CGFloat) -> UIImage {
        println(self.size)
        let newWidth = (height / self.size.height) * self.size.width
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: height))
        self.drawInRect(CGRect(x: 0, y: 0, width: newWidth, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
