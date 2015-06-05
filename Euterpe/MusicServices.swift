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
    
    func boundingBox(service: Services) -> [CGRect]{
        switch service {
        case .Pandora:
            return [CGRect()]
        default:
            return [CGRect()]
        }
    }
}



extension Services {
    var x: CGFloat {
        get {
            switch self {
            case .Pandora: return 0.05
            case .Spotify: return 0.03
            case .Soundcloud: return 7
            case .Music: return 7
            }
        }
    }
    
    var y: CGFloat {
        get {
            switch self {
            case .Pandora: return 0.67
            case .Spotify: return 0.07
            case .Soundcloud: return 7
            case .Music: return 7
            }
        }
    }
    
    var width: CGFloat {
        get {
            switch self {
            case .Pandora: return 0.75
            case .Spotify: return 7
            case .Soundcloud: return 7
            case .Music: return 7
            }
        }
    }
    
    var height: CGFloat {
        get {
            switch self {
            case .Pandora: return 0.15
            case .Spotify: return 7
            case .Soundcloud: return 7
            case .Music: return 7
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