//
//  PopularTableViewCell.swift
//  GameApp
//
//  Created by Олег Борисов on 25.12.2022.
//

import UIKit

class PopularTitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"

    var popularView: PopularViewProtocol?

    var saveGames: GameViewModel?

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let downloadTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        let selectImage = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        image?.withTintColor(.black)
        button.setImage(image, for: .normal)
        button.setImage(selectImage, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .orange
        return button
    }()

    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()

    private let worthTitleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.lineBreakMode = .byClipping
        label.textColor = .systemOrange
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

}

extension PopularTitleTableViewCell{
    func configure(with model: GameViewModel) {
        self.saveGames = model
        guard let url = URL(string: model.image) else { return }
        posterImageView.kf.setImage(with: url)
        nameTitleLabel.text = model.title.maxLength(length: 60)
        worthTitleLable.text = model.worth
        downloadTitleButton.addTarget(self, action: #selector(tapFavorite), for: .touchUpInside)
    }
}

private extension PopularTitleTableViewCell{

    func initialize(){
        posterImageViewConfigure()
        nameTitleLabelConfigure()
        downloadTitleButtonConfigure()
        worthTitleLableConfigure()
        applyConstraints()
    }

    func posterImageViewConfigure(){
        contentView.addSubview(posterImageView)
    }

    func nameTitleLabelConfigure(){
        contentView.addSubview(nameTitleLabel)
    }

    func downloadTitleButtonConfigure(){
        contentView.addSubview(downloadTitleButton)
    }

    func worthTitleLableConfigure(){
        contentView.addSubview(worthTitleLable)
    }

    func applyConstraints() {
        let posterImageViewConstraints = [
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ]

        let worthTitleLableConstraints = [
            worthTitleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            worthTitleLable.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 5),
        ]

        let downloadTitleButtonConstraints = [
            downloadTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            downloadTitleButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ]

        let nameTitleLabelConstraints = [
            nameTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameTitleLabel.widthAnchor.constraint(equalToConstant: 270)
        ]

        NSLayoutConstraint.activate([
            posterImageViewConstraints,
            downloadTitleButtonConstraints,
            nameTitleLabelConstraints,
            worthTitleLableConstraints
        ])

    }

    @objc func tapFavorite(){
        if downloadTitleButton.isSelected{
            popularView?.deleteFavoriteGame(game: saveGames!)
            downloadTitleButton.isSelected = false
        } else{
            popularView?.saveFavoriteGame(game: saveGames!)
            downloadTitleButton.isSelected = true
        }
    }

}
