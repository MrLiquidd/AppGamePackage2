//
//  File 2.swift
//  
//
//  Created by Олег Борисов on 28.12.2022.
//

import UIKit

protocol LayoutConstraintsWrapper {
    var constraints: [NSLayoutConstraint] { get }
}


extension NSLayoutConstraint: LayoutConstraintsWrapper {
    var constraints: [NSLayoutConstraint] {
        return [self]
    }
}

extension NSLayoutConstraint {
    class func activate(_ constraints: [LayoutConstraintsWrapper]) {
        activate(constraints.flatMap { $0.constraints })
    }
}
