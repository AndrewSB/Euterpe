//
//  InitialViewController.swift
//  Euterpe
//
//  Created by Andrew Breckenridge on 6/4/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit
import Photos
import Alamofire
import XCDYouTubeKit

class InitialViewController: UIViewController {
    let imagePicker = UIImagePickerController()
    var OCRDaemon: [OCR]?
    
    var image: UIImage! {
        didSet {
            rollImageView.image = image
            UserStore.nuke()
            OCRDaemon = [OCR(type: .Pandora, image: image, screenSize: view.frame.size),
                         OCR(type: .Soundcloud, image: image, screenSize: view.frame.size),
                         OCR(type: .Spotify, image: image, screenSize: view.frame.size),
                         OCR(type: .Music, image: image, screenSize: view.frame.size)]
            println("decided on \(UserStore.type). Search term is \(UserStore.term) with a confidence of \(UserStore.confidence)")
            
            Alamofire.request(.GET,"\(PUBLIC_URL)/vtcver.php")
                     .responseJSON { (_,_, JSON, _) in
                        let courseName = jsonResult[0]["courseName"]
                        let courseVersion = jsonResult[0]["courseVersion"]
                        let courseZipFile = jsonResult[0]["courseZipFile"]
                        
                        println("JSON:    courseName: \(courseName)")
                        println("JSON: courseVersion: \(courseVersion)")
                        println("JSON: courseZipFile: \(courseZipFile)")

            }
        }
        
    }

    @IBOutlet weak var rollImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        rollImageView.contentMode = .ScaleAspectFit
        
        let screenSize = self.view.frame.size
        let type = Services.Pandora
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
            self.image = pickedImage.shrinkTo(view.frame.height)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}