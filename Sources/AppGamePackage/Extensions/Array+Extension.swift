//
//  File.swift
//  
//
//  Created by Олег Борисов on 28.12.2022.
//

import UIKit

extension Array: LayoutConstraintsWrapper where Element: NSLayoutConstraint {
    var constraints: [NSLayoutConstraint] {
        return self
    }
}

