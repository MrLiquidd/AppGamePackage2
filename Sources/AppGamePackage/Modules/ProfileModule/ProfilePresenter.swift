//
//  ProfilePresenter.swift
//  Super easy dev
//
//  Created by Олег Борисов on 22.11.2022
//

protocol ProfilePresenterProtocol: AnyObject {
    func didTapEditProfile()
    func didTapDeleteAllTitles()
    func deleteComplete()
    func fetchShowProfile()
    func loadProfile(profile: [Profile])
    func setNewTheme(theme: Theme)
    func showNewTheme(newTheme: Theme)
}

class ProfilePresenter {
    weak var view: ProfileViewProtocol?
    var router: ProfileRouterProtocol
    var interactor: ProfileInteractorProtocol

    init(interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func setNewTheme(theme: Theme) {
        interactor.setNewTheme(theme: theme)
        interactor.showNewTheme()
    }

    func loadProfile(profile: [Profile]) {
        view?.showProfile(profile: profile)
    }

    func fetchShowProfile() {
        interactor.fetchProfileFromDatabase()
    }

    func didTapEditProfile(){
        router.openEditProfile()
    }
    func didTapDeleteAllTitles(){
        interactor.deleteAllTitles()
    }
    func deleteComplete(){
        view?.showDeleteComplete()
    }
    func showNewTheme(newTheme: Theme){
        view?.showNewTheme(newTheme: newTheme)
    }

}

