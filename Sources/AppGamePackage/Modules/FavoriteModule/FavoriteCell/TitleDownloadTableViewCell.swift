//
//  TitleTableViewCell.swift
//  GameApp
//
//  Created by Олег Борисов on 21.12.2022.
//

import UIKit
import Kingfisher

final class TitleDownloadTableViewCell: UITableViewCell {

    static let identifier = "TitleDownloadTableViewCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private let titlesPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()

    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}

extension TitleDownloadTableViewCell{
    public func configure(with model: GameViewModel) {
        guard let url = URL(string: model.image) else { return }
        print(url)
        titlesPosterUIImageView.kf.setImage(with: url)
        print(model.title)
        titleLabel.text = model.title
    }
}

extension TitleDownloadTableViewCell{

    func initialize(){
        titlesPosterUIImageViewConfigure()
        titleLabelConfigure()
        applyConstraints()
    }

    func titlesPosterUIImageViewConfigure(){
        contentView.addSubview(titlesPosterUIImageView)
    }
    func titleLabelConfigure(){
        contentView.addSubview(titleLabel)
    }

    func applyConstraints() {
        let titlesPosterUIImageViewConstraints = [
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 180),
            titlesPosterUIImageView.heightAnchor.constraint(equalToConstant: 120)
        ]

        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]

        NSLayoutConstraint.activate([
            titlesPosterUIImageViewConstraints,
            titleLabelConstraints
        ])
    }
}
