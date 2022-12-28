//
//  File.swift
//  
//
//  Created by Олег Борисов on 28.12.2022.
//

//import UIKit
//import CoreData
//
//class DBManager {
//    
//    private static var managedObjectContext: NSManagedObjectContext {
//        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    }
//    class func create<E>(proccess: (_ object: E) -> Void) -> Bool {
//        do {
//            proccess(NSEntityDescription.insertNewObject(forEntityName: "\(E.self)", into: managedObjectContext) as! E)
//            try managedObjectContext.save()
//            return true
//        }
//        catch let error {
//            fatalError(error.localizedDescription)
//        }
//        return false
//    }
//    class func read<E>(proccess: ((_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> Void)?) -> [E] {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(E.self)")
//        proccess?(fetchRequest)
//        do {
//            return try managedObjectContext.fetch(fetchRequest) as! [E]
//        }
//        catch let error {
//            fatalError(error.localizedDescription)
//        }
//    }
//    class func update<E>(proccess: ((_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> Void)?, update: (_ objects: [E]) -> Void) -> Bool {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(E.self)")
//        proccess?(fetchRequest)
//        do {
//            update(try managedObjectContext.fetch(fetchRequest) as! [E])
//            try managedObjectContext.save()
//            return true
//        }
//        catch let error {
//            fatalError(error.localizedDescription)
//        }
//        return false
//    }
//    
//    class func delete<E>(proccess: ((_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> Void)?, deletedObjects: ((_ objects: [E]) -> Void)?) -> Bool {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(E.self)")
//        do {
//            let objects = try managedObjectContext.fetch(fetchRequest) as! [E]
//            deletedObjects?(objects)
//            for object in objects {
//                managedObjectContext.delete(object as! NSManagedObject)
//            }
//            try managedObjectContext.save()
//            return true
//        }
//        catch let error {
//            fatalError(error.localizedDescription)
//        }
//        return false
//    }
//}
