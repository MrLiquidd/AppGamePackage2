//
//  DBHelper.swift
//  GameApp
//
//  Created by Олег Борисов on 21.12.2022.
//

import Foundation
import UIKit
import CoreData

public class DatabaseManager{
    static let shared = DatabaseManager()

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

    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func addGame(game: Game, completion: @escaping(Result<Void, Error>) -> Void){
        let context = persistentContainer.viewContext
        let item = GameItem(context: context)

        item.id = game.id
        item.title = game.title
        item.imageUrl = game.image
        item.descriptionGame = game.description
        item.worth = game.worth
        do{
            try context.save()
            completion(.success(()))
        } catch{
            completion(.failure(DatabaseError.failureToSaveData))
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

    func deleteTitleWith(model: GameItem, completion: @escaping (Result<Void, Error>)-> Void) {

        let context = persistentContainer.viewContext
        context.delete(model)

        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failureToDeleteData))
        }
    }

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

    func deleteAllTitles(completion: @escaping (Result<Void, Error>) -> Void){
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameItem")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try context.execute(batchDeleteRequest)
            completion(.success(()))
        } catch{
            completion(.failure(DatabaseError.failureToDeleteData))
        }
    }

    func deleteOldProfile(completion: @escaping (Result<Void, Error>) -> Void){
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try context.execute(batchDeleteRequest)
            completion(.success(()))
        } catch{
            completion(.failure(DatabaseError.failureToDeleteData))
        }
    }


    func putNewProfile(model: ProfileModel, completion: @escaping (Result<Void, Error>) -> Void){

        let context = persistentContainer.viewContext

        let item = Profile(context: context)
        let dataImage = model.image.jpegData(compressionQuality: 1.0)
        item.image = dataImage
        item.email = model.email
        item.name = model.name
        do{
            try context.save()
            completion(.success(()))
        } catch{
            completion(.failure(DatabaseError.failureToSaveData))
        }

    }
}
