//
//  SettingsDefaults.swift
//  GameApp
//
//  Created by Олег Борисов on 25.12.2022.
//

import Foundation

public enum UserKeyValue{
    static var themeKey = "selectedTheme"
}

public struct MTUserDefaults{
    public static var shared = MTUserDefaults()

    public var theme: Theme{
        get{
            Theme(rawValue: UserDefaults.standard.integer(forKey: UserKeyValue.themeKey)) ?? .device
        }
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: UserKeyValue.themeKey)
        }
    }
}
