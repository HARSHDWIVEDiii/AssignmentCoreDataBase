//
//  CoreData.swift
//  AssignmentCoreDataBase
//
//  Created by Mac on 16/01/24.
//

import Foundation
import CoreData
import UIKit
class DatabaseManager{
    static let shared = DatabaseManager()
    private init()
    {

    }
    func insertDataFromApiToCoreData(user : User){
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let manageContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Entity", in: manageContext)
        let eachuser = NSManagedObject(entity: (userEntity)!, insertInto: manageContext)
        eachuser.setValue(user.name, forKey: "name")
        eachuser.setValue(user.email, forKey: "email")
        do {
            try manageContext.save()
        }
        catch{
            print("data not saved")
        }
    }
    func retrivedDataFromCoreData()-> [User]?{
        var results : [User] = []
        DispatchQueue.main.async {
            guard let appDelegate1 =  (UIApplication.shared.delegate) as? AppDelegate else{
                return
            }
        
        
        let manageContext = appDelegate1.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        do{
            let result =  try manageContext.fetch(fetchRequest) as! [NSManagedObject]
            print(result)
            for eachResult in result{
                print((eachResult.value(forKey: "email"))!)
                print((eachResult.value(forKey: "name"))!)
            }
            //results = result as! [User]
        }
        catch{
            
        }
        
    }
        return results
}
   
    
}
