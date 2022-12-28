//
//  PreviewViewController.swift
//  Super easy dev
//
//  Created by Олег Борисов on 26.12.2022
//

import UIKit
import Kingfisher

protocol PreviewViewProtocol: AnyObject {
}

class PreviewViewController: UIViewController {
    // MARK: - Public
    var presenter: PreviewPresenterProtocol?

    var saveGame: GameViewModel?

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.text = "Harry potter"
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is the best movie ever to watch as a kid!"
        return label
    }()

    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemOrange
        button.setTitle("Add to Favorite", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true

        return button
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadView() {
        super.loadView()
        initialize()
    }
}

extension PreviewViewController{

    public func configure(with model: GameViewModel) {
        self.saveGame = model
        guard let url = URL(string: model.image) else { return }
        posterImageView.kf.setImage(with: url)
        titleLabel.text = model.title
        overviewLabel.text = model.description
    }
}

private extension PreviewViewController{

    func initialize(){
        configureUI()
        posterImageViewConfigure()
        posterImageViewConfigure()
        titleLabelConfigure()
        overviewLabelConfigure()
        downloadButtonConfigure()
        configureConstraints()
    }

    func configureUI(){
        view.backgroundColor = .systemBackground
    }

    func posterImageViewConfigure(){
        view.addSubview(posterImageView)
    }

    func titleLabelConfigure(){
        view.addSubview(titleLabel)
    }

    func overviewLabelConfigure(){
        view.addSubview(overviewLabel)
    }

    func downloadButtonConfigure(){
        view.addSubview(downloadButton)
        downloadButton.addTarget(self, action: #selector(self.downloadTitleAt), for: .touchUpInside)
    }

    func configureConstraints() {
        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 300)

        ]

        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]

        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]

        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]

        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)

    }

    @objc private func downloadTitleAt(){
        presenter?.saveFavoriteGames(game: saveGame!)
    }

}

// MARK: - PreviewViewProtocol
extension PreviewViewController: PreviewViewProtocol {
}
