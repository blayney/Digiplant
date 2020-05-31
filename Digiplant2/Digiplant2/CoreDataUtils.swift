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
    
    func savePlant(name: String, plantType: String, plantID: String, growthLevel: Float, group: String, rfidReturn: String) -> Plant? {
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
    
    func saveGroup(name: String) -> Group? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Group", in: managedContext)!
        
        let group = NSManagedObject(entity: entity, insertInto: managedContext)
        
        group.setValue(name, forKeyPath: "groupName")
        
        do {
            try managedContext.save()
            return group as! Group
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func testReturnPlants() -> [NSManagedObject]? {
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
    
    func returnGroupList() -> [String]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Group")
        fetchRequest.returnsObjectsAsFaults = false
        
        var groupList: [String] = []
        
        do {
            var groups = try managedContext.fetch(fetchRequest)
            for g in groups {
                var name = g.value(forKey: "groupName") ?? "No name"
                groupList.append(name as! String)
            }
            return groupList
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func returnPlantList() -> [String]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Plant")
        fetchRequest.returnsObjectsAsFaults = false
        
        var plantList: [String] = []
        
        do {
            var plants = try managedContext.fetch(fetchRequest)
            for p in plants {
                var name = p.value(forKey: "plantName") ?? "No name"
                plantList.append(name as! String)
            }
            return plantList
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func returnPlantAttributes(plantName: String) -> (String, Float, String, String, String)? {
        // Returns format (group, growth level, plant ID, plant Type, RFID return)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Plant")
        fetchRequest.predicate = NSPredicate(format: "plantName = %@", plantName)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            var plantObjects = try managedContext.fetch(fetchRequest)
            assert(plantObjects.count < 2) // There shouldn't be any duplicates
            var plantObject = plantObjects.first
            var group = plantObject?.value(forKey: "group") ?? "Default"
            var growthLevel = plantObject?.value(forKey: "growthLevel") ?? 0.0
            var plantID = plantObject?.value(forKey: "plantID") ?? "0"
            var plantType = plantObject?.value(forKey: "plantType") ?? "None"
            var rfidReturn = plantObject?.value(forKey: "rfidReturn") ?? "0"

            return (group, growthLevel, plantID, plantType, rfidReturn) as! (String, Float, String, String, String)
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func deleteAllPlants() {
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
            try managedContext.save()
        } catch let error as NSError {
            print("Delete all data in Plant error : \(error) \(error.userInfo)")
        }
    }
    
    func deleteAllGroups() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Group")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Delete all data in Group error : \(error) \(error.userInfo)")
        }
    }
    
    func deleteAllNames() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CommonName")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Delete all data in Common name error : \(error) \(error.userInfo)")
        }
    }
    
    func readDataFromCSV(fileName:String, fileType: String) -> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    /*func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\'", with: "'")
        return cleanFile
    }*/
    
    func csv(data: String) -> [String]
    {
        var result: [String] = []
        let name = data.components(separatedBy: ",")
        result = name
        return result
    }
    
    func linkCSVToCore() {
        deleteAllNames()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        var data=readDataFromCSV(fileName: "UniqueNames", fileType: "txt")!
        let csvRows = csv(data: data)
        
        for name in csvRows {
            let entity = NSEntityDescription.entity(forEntityName: "CommonName", in: managedContext)!
            
            let group = NSManagedObject(entity: entity, insertInto: managedContext)
            
            group.setValue(name, forKeyPath: "name")
            
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print("Done")
        returnNameList()
    }
    
    func returnNameList() -> [String]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CommonName")
        fetchRequest.returnsObjectsAsFaults = false
        
        var nameList: [String] = []
        
        do {
            var names = try managedContext.fetch(fetchRequest)
            for nameObj in names {
                var name = nameObj.value(forKey: "name") ?? "No name"
                nameList.append(name as! String)
            }
            print(nameList.count)
            return nameList
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func searchNameString(searchTerm: String) -> [String]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CommonName")
        fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@", searchTerm)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            var nameObjects = try managedContext.fetch(fetchRequest)
            var nameList: [String] = []
            for nameObject in nameObjects {
                var name = nameObject.value(forKey: "name") as! String
                if nameList.count <= 10 {
                    nameList.append(name)
                }
            }

            return nameList
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
 
}
