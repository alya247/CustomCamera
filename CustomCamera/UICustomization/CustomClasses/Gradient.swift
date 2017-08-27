//
//  Gradient.swift
//  CustomCamera
//
//  Created by Alya Filon on 25.08.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        let startColor = UIColor(red: 222/255.0, green: 255/255.0, blue: 201/255.0, alpha: 1).cgColor
        let endColor = UIColor(red: 163/255.0, green: 248/255.0, blue: 255/255.0, alpha: 1).cgColor
        layer.colors = [startColor, endColor]
        self.layer.insertSublayer(layer, at: 0) 
    }
}
