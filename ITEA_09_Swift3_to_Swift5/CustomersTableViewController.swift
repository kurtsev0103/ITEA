//
//  CustomersTableViewController.swift
//  core-data-habrahabr-swift

import UIKit
import CoreData

class CustomersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    typealias Select = (Customer?) -> ()
    var didSelect: Select?
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Customer", keyForSort: "name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    @IBAction func AddCustomer(sender: AnyObject) {
        performSegue(withIdentifier: "customersToCustomer", sender: nil)
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let customer = fetchedResultsController.object(at: indexPath) as! Customer
        let cell = UITableViewCell()
        cell.textLabel?.text = customer.name
        return cell
    }
 
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResultsController.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.managedObjectContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        let customer = fetchedResultsController.object(at: indexPath) as? Customer
        if let dSelect = self.didSelect {
            dSelect(customer)
            dismiss(animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "customersToCustomer", sender: customer)
        }
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "customersToCustomer" {
            let controller = segue.destination as! CustomerViewController
            controller.customer = sender as? Customer
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
                let customer = fetchedResultsController.object(at: indexPath) as! Customer
                let cell = tableView.cellForRow(at: indexPath)
                cell!.textLabel?.text = customer.name
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
