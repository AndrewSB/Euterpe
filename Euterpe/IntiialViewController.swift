//
//  InitialViewController.swift
//  Euterpe
//
//  Created by Andrew Breckenridge on 6/4/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import TesseractOCR
import AssetsLibrary
import Photos


class InitialViewController: UIViewController {
    let OCRClient = G8Tesseract(language: "eng")
    var imageIndex = 0
    let imagePicker = UIImagePickerController()
    var image: UIImage! {
        didSet {
            rollImageView.image = image
        }
    }

    @IBOutlet weak var rollImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        OCRClient.delegate = self
        imagePicker.delegate = self
        
        imagePicker.sourceType = .PhotoLibrary
    }
}

extension InitialViewController: G8TesseractDelegate {
    func shouldCancelImageRecognitionForTesseract(tesseract: G8Tesseract!) -> Bool {
        return false
    }
    
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}

extension InitialViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            rollImageView.contentMode = .ScaleAspectFit
            self.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: {
            println(self.image.size)
            self.OCRClient.image = self.image
            self.OCRClient.recognize()
            println(self.OCRClient.recognizedText)
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}