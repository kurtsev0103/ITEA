//
//  ServicesTableViewController.swift
//  core-data-habrahabr-swift

import UIKit
import CoreData

class ServicesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    typealias Select = (Service?) -> ()
    var didSelect: Select?

    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Service", keyForSort: "name")

    @IBAction func AddService(sender: AnyObject) {
        performSegue(withIdentifier: "servicesToService", sender: nil)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let service = fetchedResultsController.object(at: indexPath as IndexPath) as! Service
        let cell = UITableViewCell()
        cell.textLabel?.text = service.name
        return cell
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
        let service = fetchedResultsController.object(at: indexPath as IndexPath) as? Service
        if let dSelect = self.didSelect {
            dSelect(service)
            dismiss(animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "servicesToService", sender: service)
        }
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "servicesToService" {
            let controller = segue.destination as! ServiceViewController
            controller.service = sender as? Service
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
                let service = fetchedResultsController.object(at: indexPath) as! Service
                let cell = tableView.cellForRow(at: indexPath)
                cell!.textLabel?.text = service.name
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
