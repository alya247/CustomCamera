//
//  CaptureViewController.swift
//  CustomCamera
//
//  Created by Alya Filon on 25.08.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit
import AVFoundation

class CaptureViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    
    var captureManager = CaptureManager()
    var photo: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureManager.configureSession(withView: cameraView)
    }
}

extension CaptureViewController {
    
    @IBAction func takePhoto(_ sender: UIButton) {
        
        Animation.capture(inView: view)

        captureManager.takePhoto { [weak self] result in
            switch result {
            case .success(let image):
                if let composeViewController = self?.presentingViewController as? ComposeViewController {
                    composeViewController.photoImageView.image = image
                    self?.dismiss(animated: true, completion: nil)
                }
            case .failure(let errorMessage):
                print(errorMessage)
            case .cancel:
                break
            }
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rotateCamera(_ sender: UIButton) {
        captureManager.rotateCamera()
    }
}








