//
//  InitialViewController.swift
//  Euterpe
//
//  Created by Andrew Breckenridge on 6/4/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos

class InitialViewController: UIViewController {
    var classifier: Classifier!
    let imagePicker = UIImagePickerController()
    var OCRDaemon: [OCR]?
    
    var image: UIImage! {
        didSet {
            rollImageView.image = image
            OCRDaemon = [OCR(type: .Pandora, image: image),
                         OCR(type: .Soundcloud, image: image),
                         OCR(type: .Spotify, image: image),
                         OCR(type: .Music, image: image),]
            println("here")
        }
    }

    @IBOutlet weak var rollImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        rollImageView.contentMode = .ScaleAspectFit
    }
}


extension InitialViewController {
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}

extension InitialViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}