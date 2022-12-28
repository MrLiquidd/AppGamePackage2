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
    func deleteOldProfile()
}

class EditProfileInteractor: EditProfileInteractorProtocol {

    weak var presenter: EditProfilePresenterProtocol?
    var databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }

    func fetchProfileFromDatabase(){
        databaseManager.fetchFromDataBase{[weak self] (res:Array<Profile>?, error) in
            if let result = res{
                self?.presenter?.loadProfile(profile: result)
            } else{
                print(error!)
            }
        }
    }

    func deleteOldProfile() {
        databaseManager.deleteEntity(.ProfileEntity){ result in
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
