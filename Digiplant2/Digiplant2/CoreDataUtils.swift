//
//  CoreDataUtils.swift
//  Digiplant2
//
//  Created by Hugh Blayney on 31/05/2020.
//  Copyright © 2020 Will Blayney. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// Based on code found at https://www.raywenderlich.com/7569-getting-started-with-core-data-tutorial

struct CoreDataUtils {
    static let shared = CoreDataUtils()
    
    func save(name: String, plantType: String, plantID: String, growthLevel: Float, group: String, rfidReturn: String) -> Plant? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Plant", in: managedContext)!
        
        let plant = NSManagedObject(entity: entity, insertInto: managedContext)
        
        plant.setValue(name, forKeyPath: "plantName")
        plant.setValue(group, forKeyPath: "group")
        plant.setValue(growthLevel, forKeyPath: "growthLevel")
        plant.setValue(plantID, forKeyPath: "plantID")
        plant.setValue(plantType, forKeyPath: "plantType")
        plant.setValue(rfidReturn, forKeyPath: "rfidReturn")
        
        do {
            try managedContext.save()
            return plant as! Plant
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func testReturn() -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Plant")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func deleteAll() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Plant")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in Plant error : \(error) \(error.userInfo)")
        }
    }
 
}
