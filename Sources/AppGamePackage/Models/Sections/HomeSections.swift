//
//  HomeSections.swift
//  GameApp
//
//  Created by Олег Борисов on 25.12.2022.
//

import Foundation

enum HomeSections: Int, Hashable,CaseIterable, CustomStringConvertible{
    case upcomingSection
    case popularSection

    var description: String{
        switch self{
            case .upcomingSection: return "New Games"
            case .popularSection: return "Popular"
        }
    }
}
