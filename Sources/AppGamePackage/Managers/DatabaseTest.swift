//
//  File.swift
//  
//
//  Created by Олег Борисов on 28.12.2022.
//

import CoreData

protocol DatabaseTestProtocol: AnyObject{
    func addGame(game: Game, completion: @escaping(Result<Void, Error>) -> Void)
    func fetchGamesFromDataBase(completion: @escaping (Result<[GameItem], Error>) -> Void)
    func deleteTitleWith(model: GameItem, completion: @escaping (Result<Void, Error>)-> Void)
    func deleteAllTitles(completion: @escaping (Result<Void, Error>) -> Void)
    func fetchProfileFromDataBase(completion: @escaping (Result<[Profile], Error>) -> Void)
    func deleteOldProfile(completion: @escaping (Result<Void, Error>) -> Void)
    func addNewProfile(model: ProfileModel, completion: @escaping (Result<Void, Error>) -> Void)
}

public class DatabaseTest{


    enum DatabaseError: Error{
        case failureToSaveData
        case failureToDeleteData
        case failureToFetchData
    }


    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle.module.url(forResource: "GameApp", withExtension: "momd"),let model = NSManagedObjectModel(contentsOf: modelURL) else {
            return NSPersistentContainer()
        }
        let container = NSPersistentContainer(name: "GameApp", managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    public func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


    //MARK: - Same shit fetch
    func fetchProfileFromDataBase(completion: @escaping (Result<[Profile], Error>) -> Void){
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<Profile>
        request = Profile.fetchRequest()

        do{
            let profile = try context.fetch(request)
            completion(.success(profile))
        } catch {
            completion(.failure(DatabaseError.failureToFetchData))
        }
    }

    func fetchGamesFromDataBase(completion: @escaping (Result<[GameItem], Error>) -> Void){

        let context = persistentContainer.viewContext
        let request: NSFetchRequest<GameItem>
        request = GameItem.fetchRequest()

        do{
            let games = try context.fetch(request)
            completion(.success(games))
        } catch {
            completion(.failure(DatabaseError.failureToFetchData))
        }
    }
}
