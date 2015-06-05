//
//  Classifier.swift
//  Euterpe
//
//  Created by Andrew Breckenridge on 6/4/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import TesseractOCR

class Classifier {
    var original: UIImage
    var inverted: UIImage
    
    
    
    init(image: UIImage) {
        original = image
        inverted = original.colorInverted()
    }
}