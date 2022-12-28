//
//  File.swift
//  
//
//  Created by Олег Борисов on 28.12.2022.
//

import UIKit

protocol LayoutConstraintsWrapper {
    var constraints: [NSLayoutConstraint] { get }
}

extension Array: LayoutConstraintsWrapper where Element: NSLayoutConstraint {
    var constraints: [NSLayoutConstraint] {
        return self
    }
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
