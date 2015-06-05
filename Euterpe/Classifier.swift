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
    var original: UIImage {didSet{ self.classify() }}
    var inverted: UIImage
        
    init(image: UIImage) {
        original = image
        inverted = original.colorInverted()
    }
    
    func classify() {
        let oCRClients: [G8Tesseract] = [G8Tesseract(language: "en", engineMode: .TesseractCubeCombined),G8Tesseract(language: "en", engineMode: .TesseractCubeCombined),G8Tesseract(language: "en", engineMode: .TesseractCubeCombined),G8Tesseract(language: "en", engineMode: .TesseractCubeCombined)]
        
        for (index, element) in enumerate(oCRClients) {
            element.charBlacklist =  "‘''()"
            element.image = self.original
        
            
        }
        
        
    }
}