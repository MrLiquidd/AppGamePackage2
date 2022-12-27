//
//  SettingSections.swift
//  GameApp
//
//  Created by Олег Борисов on 23.12.2022.
//

import Foundation
import UIKit

protocol SectionType: CustomStringConvertible{
    var containsArrow: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible{
    case Profile
    case ClearData


    var description: String{
        switch self{
            case .Profile: return "Profile"
            case .ClearData: return "Clear Data"
        }
    }
}


enum ProfileOptions: Int, CaseIterable, SectionType {
    case editProfile

    var containsArrow: Bool { return false}

    var description: String{
        switch self{
            case .editProfile: return "Edit Profile"
        }
    }
}

enum ClearDatabaseOptions: Int, CaseIterable, SectionType{
    case clearData
    var containsArrow: Bool{
        switch self{
            case .clearData: return false
        }
    }
    var description: String{
        switch self{
            case .clearData: return "Clear"
        }
    }
}

public enum Theme: Int{
    case device
    case light
    case dark

    public func getUserInterfaceStyle() -> UIUserInterfaceStyle{
        switch self{
            case .device:
                return .unspecified
            case .light:
                return .light
            case .dark:
                return .dark
        }
    }
}



