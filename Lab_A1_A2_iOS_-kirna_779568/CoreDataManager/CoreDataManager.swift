//
//  CoreDataManager.swift
//  Lab_A1_A2_iOS_-kirna_779568
//
//  Created by Kirnaon 19/09/21.
//  Copyright © 2021 Kirnaon. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager : NSObject{
    
    static let shared = CoreDataManager()
    let savedDataKey = "savedDataKey"
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Lab_A1_A2_iOS_-kirna_779568")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
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
    
    func loadFromPlist() {
           let backgroundContext = persistentContainer.newBackgroundContext()
               persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
              _ = NSEntityDescription.entity(forEntityName: "Item", in: backgroundContext)!
            
            let userDefaults = UserDefaults.standard
    //         == false
            if userDefaults.bool(forKey: savedDataKey) == false {
                guard let plistUrl = Bundle.main.url(forResource: "Items", withExtension:"plist") else {
                    return
                }
                do {
                    let plistData = try Data(contentsOf: plistUrl)
                    let plistValues = try PropertyListDecoder().decode([ItemStruct].self, from: plistData)
                    
                   for items in plistValues {
                       
                    let entity = NSEntityDescription.entity(forEntityName: "Item", in: backgroundContext)!
                    
                       let newEntity = Item(entity: entity, insertInto: backgroundContext)
                    newEntity.itemId = Int32(items.itemId!)
                    newEntity.itemName = items.itemName!
                    newEntity.itemDescription = items.itemDescription!
                    newEntity.itemCost = items.itemCost!
                    newEntity.itemProvider = items.itemProvider!

                       try backgroundContext.save()
                           
                    UserDefaults.standard.set(true, forKey: savedDataKey)
                    UserDefaults.standard.set(items.itemId!, forKey: "LastID")
                     }
                } catch {
                    print(error)
                }
        
              
            }
        }
    
    
    
    
    
}
