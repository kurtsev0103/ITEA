//
//  Order.swift
//  core-data-habrahabr-swift

import Foundation
import CoreData

class Order: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Order"), insertInto: CoreDataManager.instance.managedObjectContext)
    }

    class func getRowsOfOrder(order: Order) -> NSFetchedResultsController<NSFetchRequestResult> {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RowOfOrder")
        
        let sortDescriptor = NSSortDescriptor(key: "service.name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "%K == %@", "order", order)
        fetchRequest.predicate = predicate
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }
    
}
