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
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: .zeroPoint, size: CGSize(width: 22, height: 22)))
    
    var moviePlayer: MPMoviePlayerViewController!
    var audioPlayer: AVAudioPlayer!
    
    var audioUrl: NSURL? {
        didSet {
            moviePlayer = nil
            audioPlayer = nil
            
            if let url = audioUrl {
                if UserStore.showAudioView {
                    moviePlayer = MPMoviePlayerViewController(contentURL: url)
                    presentViewController(moviePlayer, animated: true, completion: nil)
                } else {
                    audioPlayer = AVAudioPlayer(contentsOfURL: url, error: nil)
                    audioPlayer.play()
                }
            }
        }
    }
    
    var image: UIImage! {
        didSet {
            rollImageView.image = image
            UserStore.nuke()
            audioUrl = nil
            OCRDaemon = [OCR(type: .Pandora, image: image, screenSize: view.frame.size),
                         OCR(type: .Soundcloud, image: image, screenSize: view.frame.size),
                         OCR(type: .Spotify, image: image, screenSize: view.frame.size),
                         OCR(type: .Music, image: image, screenSize: view.frame.size)]
            println("decided on \(UserStore.type). Search term is \(UserStore.term) with a confidence of \(UserStore.confidence)")
            
            Alamofire.request(.POST, "http://52.26.88.219:4567/video", parameters: ["q": UserStore.term!])
                .responseString { (_ , _, string, _) in
                    println(string)
                    XCDYouTubeClient.defaultClient().getVideoWithIdentifier(string, completionHandler: { (video, error) in
                        if video != nil {
                            println(video.streamURLs[140] as? NSURL)
                            self.audioUrl = video.streamURLs[140] as? NSURL
                        }
                        self.activityIndicator.stopAnimating()
                    })
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
        
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
}


extension InitialViewController {
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func rotated(sender: UIRotationGestureRecognizer) {
        self.performSegueWithIdentifier("segueToSettings", sender: self)
    }
    
    @IBAction func unwindToPromptPickerViewController(segue: UIStoryboardSegue) {}
}

extension InitialViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        dismissViewControllerAnimated(true, completion: {
            self.activityIndicator.startAnimating()
            
            
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.image = pickedImage.shrinkTo(self.view.frame.height)
            }
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}