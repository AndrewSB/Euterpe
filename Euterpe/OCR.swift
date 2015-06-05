//
//  OCR.swift
//  Euterpe
//
//  Created by Andrew Breckenridge on 6/5/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import TesseractOCR

class OCR {
    var type: Services
    var image: UIImage
    var engines: [OCREngine]
    var confidence: (Double, Double) = (0, 0)
    
    init(type: Services, image: UIImage) {
        self.type = type
        self.image = image
        self.engines = [OCREngine(image: image, boundingRect: type.boundingRect), OCREngine(image: image.colorInverted(), boundingRect: type.boundingRect)]
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.engines[0].recognize()
            self.confidence.0 = self.engines[0].confidence!
        })
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.engines[1].recognize()
            self.confidence.1 = self.engines[1].confidence!
        })
    }
}

class OCREngine: G8Tesseract {
    var confidence: Double?
    
    init(image: UIImage, boundingRect: CGRect) {
        super.init(language: "en", configDictionary: nil, configFileNames: nil, absoluteDataPath: nil, engineMode: G8OCREngineMode.TesseractCubeCombined, copyFilesFromResources: false)
        
        super.image = image
        super.rect = boundingRect
    }
}
