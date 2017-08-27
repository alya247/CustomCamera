//
//  ComposeViewController.swift
//  CustomCamera
//
//  Created by Alya Filon on 26.08.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var whiteBackView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        whiteBackView.decorator.apply(Style.shadow)
        photoImageView.decorator.apply(Style.shadow, Style.roundCorners(round: 2))
    }
}

extension ComposeViewController {
    
    @IBAction func makePhoto(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let captureViewController = storyboard.instantiateViewController(withIdentifier: "captureVC") as! CaptureViewController
        
        present(captureViewController, animated: true, completion: nil)
    }
}
