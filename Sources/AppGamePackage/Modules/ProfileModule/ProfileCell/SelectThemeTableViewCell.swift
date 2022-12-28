//
//  SelectThemeTableViewCell.swift
//  GameApp
//
//  Created by Олег Борисов on 24.12.2022.
//

import UIKit

class SelectThemeTableViewCell: UITableViewCell {

    static let identifier = "SelectThemeTableViewCell"

    var labelTheme: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SelectThemeTableViewCell{
    func initialize(){
        labelThemeConfigure()
    }
    func labelThemeConfigure(){
        addSubview(labelTheme)
        labelTheme.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        labelTheme.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
