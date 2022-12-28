//
//  DBHelper.swift
//  GameApp
//
//  Created by Олег Борисов on 21.12.2022.
//

import CoreData

protocol DatabaseManagerProtocol: AnyObject{
    func addGame(game: GameViewModel, completion: @escaping(Result<Void, Error>) -> Void)
    func addNewProfile(model: ProfileModel, completion: @escaping (Result<Void, Error>) -> Void)

    func deleteTitleWith(model: GameItem, completion: @escaping (Result<Void, Error>)-> Void)

    func fetchFromDataBase<E>(completion: @escaping (_ result: [E]?, _ error: String?) -> (Void))
    func deleteEntity(_ entity: CleanEntity ,completion: @escaping (Result<Void, Error>) -> Void)
}

enum CleanEntity: CustomStringConvertible{
    case ProfileEntity
    case GamesEntity

    var description: String{
        switch self{
            case .GamesEntity: return "GameItem"
            case .ProfileEntity: return "Profile"
        }
    }
}


public class DatabaseManager: DatabaseManagerProtocol{

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

    func deleteTitleWith<E>(model: E, completion: @escaping (Result<Void, Error>)-> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(E.self)")

        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects{
                context.delete(object as! NSManagedObject)
            }
            completion(.success(()))

        } catch {
            completion(.failure(DatabaseError.failureToDeleteData))
        }
    }

    func deleteEntity(_ entity: CleanEntity ,completion: @escaping (Result<Void, Error>) -> Void){
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.description)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try context.execute(batchDeleteRequest)
            completion(.success(()))
        } catch{
            completion(.failure(DatabaseError.failureToDeleteData))
        }
    }

    func addNewProfile(model: ProfileModel, completion: @escaping (Result<Void, Error>) -> Void){
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

    func addGame(game: GameViewModel, completion: @escaping(Result<Void, Error>) -> Void){
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

    func fetchFromDataBase<E>(completion: @escaping (_ result: [E]?, _ error: String?) -> (Void)){
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(E.self)")
        do{
            let result = try context.fetch(fetchRequest) as! [E]
            completion(result, nil)
        } catch {
            completion(nil, error.localizedDescription)
        }
    }

}
