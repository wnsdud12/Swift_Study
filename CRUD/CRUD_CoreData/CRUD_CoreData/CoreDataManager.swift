//
//  CoreDataManager.swift
//  CRUD_CoreData
//
//  Created by 박준영 on 2022/07/01.
//

import CoreData
import Foundation
import UIKit

class CoreDataManager {

    static var shared = CoreDataManager()

    func create(_ data: Person) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)

        if let entity = entity {
            let person = NSManagedObject(entity: entity, insertInto: context)
            person.setValue(data.name, forKey: "name")
            person.setValue(data.phoneNumber, forKey: "phoneNumber")
            person.setValue(data.shortcutNumber, forKey: "shortcutNumber")

            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func read() -> [Contact]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        do {
            let contacts = try context.fetch(Contact.fetchRequest()) as! [Contact]
            print("///read()")
            contacts.forEach{ print($0.name, $0.phoneNumber, $0.shortcutNumber) }
            print("///")
            return contacts
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }


    func delete(object: NSManagedObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        context.delete(object)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteAll(request: NSFetchRequest) {
        let request = request.fetchRe
    }

}

struct Person {
    var name: String
    var phoneNumber: String
    var shortcutNumber: Int
}
