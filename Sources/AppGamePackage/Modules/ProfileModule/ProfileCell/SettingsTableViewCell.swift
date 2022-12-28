//
//  SettingsTableViewCell.swift
//  GameApp
//
//  Created by Олег Борисов on 23.12.2022.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {

    static let identifier = "SettingsTableViewCell"

    var sectionType: SectionType?{
        didSet{
            guard let sectionType = sectionType else { return }
            textLabel?.text = sectionType.description
        }
    }

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


