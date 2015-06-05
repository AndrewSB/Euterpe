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
        OCRClient.charBlacklist = "‘''()"
        OCRClient.engineMode = .CubeOnly
        
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        
        let w = self.view.frame.width
        let h = self.view.frame.height
        
        let fwyView = UIView(frame: CGRect(x: 0.02 * w, y: 0.07 * h, width: 0.92*w, height: 0.18*h))
        fwyView.backgroundColor = UIColor.redColor()
        fwyView.alpha = 0.5
        
        [fwyView].map({ self.view.addSubview($0) })
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

            
            
            self.image = pickedImage.colorInverted()
        }
        
        dismissViewControllerAnimated(true, completion: {
            println(self.image.size)
            self.OCRClient.image = self.image
            self.OCRClient.recognize()
            println(self.OCRClient.recognizedText)
            println("----------")
            println(self.OCRClient.recognizedBlocksByIteratorLevel(.Block))
            println("----------")
            println(self.OCRClient.recognizedBlocksByIteratorLevel(G8PageIteratorLevel.Paragraph))
            println("----------")
            println(self.OCRClient.recognizedBlocksByIteratorLevel(G8PageIteratorLevel.Symbol))
            println("----------")
            println(self.OCRClient.recognizedBlocksByIteratorLevel(G8PageIteratorLevel.Textline))
            println("----------")
            println(self.OCRClient.recognizedBlocksByIteratorLevel(G8PageIteratorLevel.Word))
            println("----------")
            
            println("\n\n\n\n\n----------")
            var lines = [G8RecognizedBlock]()
            for line in self.OCRClient.recognizedBlocksByIteratorLevel(.Textline) {
                lines.append(line as! G8RecognizedBlock)
            }
            
            lines[0].description
            
            println(lines.sorted({ $0.confidence > $1.confidence }).map({ "\($0.text) \($0.boundingBoxAtImageOfSize(self.view.frame.size))" })[0...2])
            self.image = self.OCRClient.thresholdedImage
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func colorInverted(image: UIImage) -> UIImage {
        let cIImage =  CIImage(CGImage: image.CGImage)
        var invertFilter = CIFilter(name: "CIColorInvert")
        cIImage.setValue(invertFilter, forKey: kCIInputImageKey)
        
        let cIOutputImage = invertFilter.outputImage
        
        let ciContext = CIContext(options:[kCIContextUseSoftwareRenderer: true])
        let cgOutputImage = ciContext.createCGImage(cIOutputImage, fromRect: cIOutputImage.extent())
        
        return UIImage(CGImage: cgOutputImage, scale: 1, orientation: .Up)!
    }

}