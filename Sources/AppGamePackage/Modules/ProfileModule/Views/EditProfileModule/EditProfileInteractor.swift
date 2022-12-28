//
//  EditProfileInteractor.swift
//  Super easy dev
//
//  Created by Олег Борисов on 26.12.2022
//

import Foundation

protocol EditProfileInteractorProtocol: AnyObject {
    func putNewProfile(model: ProfileModel)
    func fetchProfileFromDatabase()
    func deleteOldProfile(model:ProfileModel)
}

class EditProfileInteractor: EditProfileInteractorProtocol {

    weak var presenter: EditProfilePresenterProtocol?
    var databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }

    func fetchProfileFromDatabase(){
        databaseManager.fetchProfileFromDataBase { result in
            switch result{
                case .success(let profile):
                    self.presenter?.loadProfile(profile: profile)
                case .failure(let error): print(error.localizedDescription)
            }
        }
    }

    func deleteOldProfile(model: ProfileModel) {
        databaseManager.deleteOldProfile { result in
            switch result{
                case .success():
                    print("Successfully delted")
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

    func putNewProfile(model: ProfileModel){
        databaseManager.addNewProfile(model: model) { result in
            switch result{
                case .success():
                    NotificationCenter.default.post(name: NSNotification.Name("updateProfile"), object: nil)
                case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
