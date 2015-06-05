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
    var engines: [OCREngine]!
    var confidence: (Double?, Double?) = (0, 0)
    
    init(type: Services, image: UIImage, screenSize: CGSize) {
        self.type = type
        self.image = image
        let selectionRect = CGRect(x: screenSize.width * type.x, y: screenSize.height * type.y,
            width: screenSize.width * type.width, height: screenSize.height * type.height)
        
        //http://studyswift.blogspot.com/2014/11/cifilter-invert-photo-color.html
        let ciPictureSelected = CIImage(image: image)
        var myFilter = CIFilter(name: "CIColorInvert")
        myFilter.setValue(ciPictureSelected, forKey: kCIInputImageKey)
        let ciOutputImage = myFilter.outputImage
        let ciContext = CIContext(options:[kCIContextUseSoftwareRenderer: true])
        let cgOutputImage = ciContext.createCGImage(ciOutputImage, fromRect: ciOutputImage.extent())
        let invertedImage = UIImage(CGImage: cgOutputImage, scale: 1, orientation: .Up)!
        
        
        self.engines = [OCREngine(image: image, boundingRect: selectionRect), OCREngine(image: invertedImage, boundingRect: selectionRect)]
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.engines[0].recognize()
            println(self.engines[0].recognizedBlocksByIteratorLevel(.Textline))
        })
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.engines[1].recognize()
            println(self.engines[1].recognizedBlocksByIteratorLevel(.Textline))
        })
        UserStore.checkNewMatch(engines[0], type: type)
        UserStore.checkNewMatch(engines[1], type: type)
        self.engines = nil
    }
}

class OCREngine: G8Tesseract {
    init(image: UIImage, boundingRect: CGRect) {
        super.init(language: "eng", configDictionary: nil, configFileNames: nil, absoluteDataPath: nil, engineMode: G8OCREngineMode.TesseractCubeCombined, copyFilesFromResources: false)
        
        super.image = image
        super.rect = boundingRect
    }
}
