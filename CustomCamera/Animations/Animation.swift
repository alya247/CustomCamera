//
//  Animation.swift
//  CustomCamera
//
//  Created by Alya Filon on 27.08.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import UIKit

class Animation {
    
    static func capture(inView view: UIView, completion: (() -> Void)? = nil) {
        let blackView = UIView(frame: view.frame)
        blackView.backgroundColor = .black
        view.addSubview(blackView)
        UIView.animate(withDuration: 1, animations: {
            blackView.backgroundColor = .clear
        }, completion: { _ in
            blackView.removeFromSuperview()
            completion?()
        })
    }
}
