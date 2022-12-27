//
//  EditProfilePresenter.swift
//  Super easy dev
//
//  Created by Олег Борисов on 26.12.2022
//

protocol EditProfilePresenterProtocol: AnyObject {
    func fetchShowProfile()
    func putNewProfile(model: ProfileModel)

    func loadProfile(profile: [Profile])
}

class EditProfilePresenter {
    weak var view: EditProfileViewProtocol?
    var router: EditProfileRouterProtocol
    var interactor: EditProfileInteractorProtocol

    init(interactor: EditProfileInteractorProtocol, router: EditProfileRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension EditProfilePresenter: EditProfilePresenterProtocol {
    func putNewProfile(model: ProfileModel) {
        interactor.deleteOldProfile(model:model)
        interactor.putNewProfile(model: model)
    }

    func loadProfile(profile: [Profile]) {
        view?.showProfile(profile: profile)
    }

    func fetchShowProfile() {
        interactor.fetchProfileFromDatabase()
    }

}
