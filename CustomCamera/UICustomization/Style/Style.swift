//
//  Style.swift
//  CustomCamera
//
//  Created by Alya Filon on 26.08.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import UIKit

struct Style {
    
    static func roundCorners(round: CGFloat) -> Decoration<UIView> {
        return { [round] (view: UIView) -> Void in
            view.layer.cornerRadius = round
        }
    }
    
    static var shadow: Decoration<UIView> {
        return { (view: UIView) -> Void in
            view.layer.shadowOpacity = 1
            view.layer.shadowRadius = 15
            view.layer.shadowOffset = CGSize(width: 0, height: 25.0)
            view.layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        }
    }
}
