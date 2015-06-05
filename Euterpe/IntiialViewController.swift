//
//  InitialViewController.swift
//  Euterpe
//
//  Created by Andrew Breckenridge on 6/4/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import TesseractOCR

class InitialViewController: UIViewController {
    let OCRClient = G8Tesseract(language: "eng")

    @IBOutlet weak var rollImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        OCRClient.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension InitialViewController {
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        println("ayy")
    }
}

extension InitialViewController: G8TesseractDelegate {
    func shouldCancelImageRecognitionForTesseract(tesseract: G8Tesseract!) -> Bool {
        return false
    }
}