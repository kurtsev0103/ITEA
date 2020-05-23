//
//  Service.swift
//  core-data-habrahabr-swift

import Foundation
import CoreData

class Service: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Service"), insertInto: CoreDataManager.instance.managedObjectContext)
    }

}
