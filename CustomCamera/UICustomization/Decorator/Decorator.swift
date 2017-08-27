//
//  Decorator.swift
//  CustomCamera
//
//  Created by Alya Filon on 26.08.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation

typealias Decoration<T> = (T) -> Void

struct Decorator<T> {
    let object: T
    
    func apply(_ decorations: Decoration<T>...) -> Void {
        decorations.forEach({ $0(object) })
    }
}

protocol DecoratorCompatible {
    associatedtype DecoratorCompatibleType
    var decorator: Decorator<DecoratorCompatibleType> { get }
}

extension DecoratorCompatible {
    var decorator: Decorator<Self> {
        return Decorator(object: self)
    }
}
