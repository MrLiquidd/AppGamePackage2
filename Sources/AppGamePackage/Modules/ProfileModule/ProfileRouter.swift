//
//  ProfileRouter.swift
//  Super easy dev
//
//  Created by Олег Борисов on 22.11.2022
//

protocol ProfileRouterProtocol {
    func openEditProfile()
}

class ProfileRouter: ProfileRouterProtocol {
    weak var viewController: ProfileViewController?

    func openEditProfile(){
        let vc = EditProfileModuleBuilder.build()
        viewController?.present(vc, animated: true)

    }
}
