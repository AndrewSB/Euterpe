//
//  NSUserdefaultStore.swift
//  Euterpe
//
//  Created by Andrew Breckenridge on 6/5/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import Foundation
import TesseractOCR

let set = NSUserDefaults.standardUserDefaults().setObject
let get = NSUserDefaults.standardUserDefaults().objectForKey

class UserStore {
    class var confidence: Double? {
        get {
            return get("confidence") as? Double
        }
        set {
            set(newValue, forKey: "confidence")
        }
    }
    
    class var term: String? {
        get {
            return get("term") as? String
        }
        set {
            set(newValue, forKey: "term")
        }
    }
    
    class var type: Services? {
        get {
            if let str = get("type") as? String {
                return Services(type: str)
            } else {
                return nil
            }
        
        }
        set {
            set(newValue?.description, forKey: "type")
        }
    }
    
    class func checkNewMatch(engine: OCREngine, type: Services) {
        var normalizedConfidence = 0.5
        var text = ""
        let lines = engine.recognizedBlocksByIteratorLevel(.Textline)
        
        switch type {
        case .Pandora:
            for line in lines {
                if let line = line as? G8RecognizedBlock {
                    if line.confidence > 0.5 {
                        text += "\(line.text) "
                        normalizedConfidence += Double(line.confidence)
                    }
                }
            }
            normalizedConfidence += 1
        case .Music:
            var musicLines = lines
            while musicLines.count > 2 {
                musicLines.removeAtIndex(0)
            }
            
            for line in musicLines {
                if let line = line as? G8RecognizedBlock {
                    if line.confidence > 0.5 {
                        text += "\(line.text) "
                        normalizedConfidence += Double(line.confidence) - ((1 - Double(line.confidence)) * 0.1)
                    }
                    if line.text.rangeOfString("lll") != nil { normalizedConfidence -= 100 }
                }
            }
        default:
            for line in lines {
                if let line = line as? G8RecognizedBlock {
                    if line.confidence > 0.5 {
                        text += "\(line.text) "
                        normalizedConfidence += Double(line.confidence) - ((1 - Double(line.confidence)) * 0.1)
                    }
                }
            }
        }
        
        normalizedConfidence = normalizedConfidence / Double(lines.count)
    
        if normalizedConfidence > UserStore.confidence {
            UserStore.term = text.stringByReplacingOccurrencesOfString("\n", withString: " ")
            UserStore.confidence = normalizedConfidence
            UserStore.type = type
        }
    }
    
    class func nuke() {
        term = nil
        confidence = nil
    }
}