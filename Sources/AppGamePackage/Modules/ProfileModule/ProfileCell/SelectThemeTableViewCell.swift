//
//  SelectThemeTableViewCell.swift
//  GameApp
//
//  Created by Олег Борисов on 24.12.2022.
//

import UIKit

class SelectThemeTableViewCell: UITableViewCell {

    static let identifier = "SelectThemeTableViewCell"

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
