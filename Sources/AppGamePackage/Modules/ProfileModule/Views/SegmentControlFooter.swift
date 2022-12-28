//
//  segmentControlFooter.swift
//  GameApp
//
//  Created by Олег Борисов on 25.12.2022.
//

import Foundation
import UIKit

protocol SegmentControlFooterProtocol: AnyObject{
    func showNewTheme(theme: Theme)
}

class SegmentControlFooter: UIView{

    weak var userDefaults: MTUserDefaultsProtocol?

    var profileProtocol: ProfileViewProtocol?

    private let segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Device","Light","Dark"])
        segmentControl.backgroundColor = .systemBackground
        segmentControl.selectedSegmentTintColor = .systemOrange
        segmentControl.selectedSegmentIndex = 0
        segmentControl.tintColor = .label
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    @objc func segmentChange(){
        let theme = Theme(rawValue: segmentControl.selectedSegmentIndex) ?? .device

        profileProtocol?.setNewTheme(theme: theme)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SegmentControlFooter{
    func initialize(){
        segmentControlConfigure()
        applyConstraints()
    }

    func segmentControlConfigure(){
        addSubview(segmentControl)
        segmentControl.selectedSegmentIndex = userDefaults?.theme.rawValue ?? 0
        segmentControl.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
    }

    func applyConstraints(){
        NSLayoutConstraint.activate([
            segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            segmentControl.heightAnchor.constraint(equalToConstant: 44)])
    }
}

extension SegmentControlFooter: SegmentControlFooterProtocol{
    func showNewTheme(theme: Theme) {
        UIView.animate(withDuration: 0.5) {
            self.window?.overrideUserInterfaceStyle = theme.getUserInterfaceStyle()
        }
    }
}
