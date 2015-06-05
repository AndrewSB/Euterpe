//
//  MusicServices.swift
//  Euterpe
//
//  Created by Andrew Breckenridge on 6/4/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

enum Services {
    case Pandora
    case Spotify
    case Soundcloud
    case Music
    
    init(type: String) {
        switch type {
        case "Pandora": self = .Pandora
        case "Spotify": self = .Spotify
        case "Soundcloud": self = .Soundcloud
        case "Music": self = .Music
        default: self = .Pandora; assert(false == true, "sup bruh")
        }
    }
    
    var boundingRect: CGRect {
        get {
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }
}



extension Services {
    var x: CGFloat {
        get {
            switch self {
            case .Pandora: return 0.05
            case .Spotify: return 0.2
            case .Soundcloud: return 0.02
            case .Music: return 0
            }
        }
    }
    
    var y: CGFloat {
        get {
            switch self {
            case .Pandora: return 0.67
            case .Spotify: return 0.58
            case .Soundcloud: return 0.07
            case .Music: return 0.65
            }
        }
    }
    
    var width: CGFloat {
        get {
            switch self {
            case .Pandora: return 0.75
            case .Spotify: return 0.65
            case .Soundcloud: return 0.92
            case .Music: return 1
            }
        }
    }
    
    var height: CGFloat {
        get {
            switch self {
            case .Pandora: return 0.15
            case .Spotify: return 0.14
            case .Soundcloud: return 0.18
            case .Music: return 0.18
            }
        }
    }
}

extension Services: Printable {
    var description: String {
        get {
            switch self {
            case .Pandora: return "Pandora"
            case .Spotify: return "Spotify"
            case .Soundcloud: return "Soundcloud"
            case .Music: return "Music"
            }
        }
    }
}