//
//  UserInfoHeader.swift
//  GameApp
//
//  Created by Олег Борисов on 23.12.2022.
//

import UIKit

class UserInfoHeader: UIView {

    var profileProtocol: ProfileViewProtocol?

    // MARK: - Properties
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "mail.mail@mail.com"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let image = UIImage(systemName: "square.and.pencil.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        image?.withTintColor(.black)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemOrange
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UserInfoHeader{
    func configure(profile: [Profile]){
        let profile = profile.last
        usernameLabel.text = profile?.name
        emailLabel.text = profile?.email
        if let data = profile?.image{
            if let image = UIImage(data: data){
                profileImageView.image = image
            }
        }
    }
}

private extension UserInfoHeader{
    func initialize(){
        profileImageViewConfigure()
        usernameLabelConfigure()
        emailLabelConfigure()
        editButtonConfigure()
        notificationCenterConfigure()

    }

    func notificationCenterConfigure(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("updateProfile"), object: nil, queue: nil) { _ in
            self.profileProtocol?.fetchShowProfile()
        }
    }

    func profileImageViewConfigure(){
        let profileImageDimension: CGFloat = 60
        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.layer.cornerRadius = profileImageDimension / 2
    }
    func usernameLabelConfigure(){
        addSubview(usernameLabel)
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
    }
    func emailLabelConfigure(){
        addSubview(emailLabel)
        emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
    }

    func editButtonConfigure(){
        addSubview(editButton)
        editButton.addTarget(self, action: #selector(editProfileAction), for: .touchUpInside)
        editButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        editButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }

    @objc func editProfileAction(){
        profileProtocol?.didTapEditProfile()
    }
}
