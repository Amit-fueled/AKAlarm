//
//  CoreData.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 03/12/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import UIKit

import UIKit
import CoreData

class CoreData: NSObject {
    
    ///Create object for Engine
    class var Object: CoreData {
        struct Singleton {
            static let instance = CoreData()
        }
        return Singleton.instance
    }
    
    /**
     init Engine
     */
    fileprivate override init(){
        super.init()
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "DS.DS" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "AKAlarm", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("AKAlarm")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() -> Bool {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error1 as NSError {
                    error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    return false
                }
            }
        }
        
        return true
    }
    
    func getRequest(_ entityName: String , nsPredicate:NSPredicate?)->[AnyObject]?{
        
        let context = self.managedObjectContext;
        let predicate = nsPredicate
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        _ = NSEntityDescription.entity(forEntityName: entityName, in: context!)
        
        if( predicate != nil ){
            fetchRequest.predicate = predicate
        }
        
        let results = try? context?.fetch(fetchRequest)
        
        return results! as [AnyObject]?
        
    }
    
    
    func insert(_ entityName:String,dict:Dictionary<String,AnyObject>,saveContext:Bool=true) -> Bool {
        
        var result = false
        let context = self.managedObjectContext
        _ = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context!)
        let attributesByName = entity!.attributesByName
        let object : NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context!)
        for name in attributesByName.keys{
            if( dict[name] != nil ){
                
                object.setValue(dict[name], forKey: name)
            }else
            {
                object.setValue(nil, forKey: name)
            }
        }
        
        if saveContext{
            result = self.saveContext()
        }
        
        return result
    }
    
    
    func update(_ entityName:String,predicate: NSPredicate?,key:String,val:AnyObject,saveContext:Bool=true){
        
        var results = self.getRequest(entityName, nsPredicate: predicate)
        if( results?.count == 1 ){
            let object: NSManagedObject = results![0] as! NSManagedObject
            object.setValue(val, forKey: key)
            
            if(saveContext){
                _ = self.saveContext()
            }
            
        }
        
        
    }
    
}


