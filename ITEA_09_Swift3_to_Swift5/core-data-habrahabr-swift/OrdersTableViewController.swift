//
//  OrdersTableViewController.swift
//  core-data-habrahabr-swift

import UIKit
import CoreData

class OrdersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Order", keyForSort: "date")

    @IBAction func AddOrder(sender: AnyObject) {
        performSegue(withIdentifier: "ordersToOrder", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let order = fetchedResultsController.object(at: indexPath as IndexPath) as! Order
        configCell(cell: cell, order: order)
        return cell
    }
    
    func configCell(cell: UITableViewCell, order: Order) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let nameOfCustomer = (order.customer == nil) ? "-- Unknown --" : (order.customer!.name!)
        cell.textLabel?.text = formatter.string(from: order.date as Date) + "\t" + nameOfCustomer
    }
    
    // MARK: - Table View Delegate
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResultsController.object(at: indexPath as IndexPath) as! NSManagedObject
            CoreDataManager.instance.managedObjectContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let order = fetchedResultsController.object(at: indexPath as IndexPath) as? Order
        performSegue(withIdentifier: "ordersToOrder", sender: order)
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ordersToOrder" {
            let controller = segue.destination as! OrderViewController
            controller.order = sender as? Order
        }
    }
    // MARK: - Fetched Results Controller Delegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    private func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeObject anObject: AnyObject, atIndexPath indexPath: IndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            
        case .update:
            if let indexPath = indexPath {
                let order = fetchedResultsController.object(at: indexPath as IndexPath) as! Order
                let cell = tableView.cellForRow(at: indexPath as IndexPath)
                configCell(cell: cell!, order: order)
            }
            
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

}
