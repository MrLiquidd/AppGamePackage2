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

protocol MTUserDefaultsProtocol: AnyObject{
    var theme: Theme { get set }
}

public class MTUserDefaults: MTUserDefaultsProtocol{

    public var theme: Theme{
        get{
            Theme(rawValue: UserDefaults.standard.integer(forKey: UserKeyValue.themeKey)) ?? .device
        }
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: UserKeyValue.themeKey)
        }
    }
}
