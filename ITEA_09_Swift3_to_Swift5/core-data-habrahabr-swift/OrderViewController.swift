//
//  OrderViewController.swift
//  core-data-habrahabr-swift

import UIKit
import CoreData

class OrderViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    var order: Order?
    var table: NSFetchedResultsController<NSFetchRequestResult>?
    
    @IBOutlet weak var dataPicker: UIDatePicker!
    @IBOutlet weak var textFieldCustomer: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchMade: UISwitch!
    @IBOutlet weak var switchPaid: UISwitch!

    @IBAction func save(sender: AnyObject) {
        saveOrder()
        dismiss(animated: true, completion: nil)
   }
    
    @IBAction func cancel(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choiceCustomer(sender: AnyObject) {
        performSegue(withIdentifier: "orderToCustomers", sender: nil)
    }
    
    @IBAction func AddRowOfOrder(sender: AnyObject) {
        if let order = order {
            let newRowOfOrder = RowOfOrder()
            newRowOfOrder.order = order
            performSegue(withIdentifier: "orderToRowOfOrder", sender: newRowOfOrder)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if order == nil {
            order = Order()
            order!.date = NSDate()
        }

        if let order = order {
            dataPicker.date = order.date as Date
            switchMade.isOn = order.made
            switchPaid.isOn = order.paid
            textFieldCustomer.text = order.customer?.name
            table = Order.getRowsOfOrder(order: order)
            table!.delegate = self
            do {
                try table!.performFetch()
            } catch {
                print(error)
            }
        }
    }

    func saveOrder() {
        if let order = order {
            order.date = dataPicker.date as NSDate
            order.made = switchMade.isOn
            order.paid = switchPaid.isOn
            CoreDataManager.instance.saveContext()
        }
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.identifier! {
            
        case "orderToCustomers":
            let viewController = segue.destination as! CustomersTableViewController
            viewController.didSelect = { [unowned self] (customer) in
                if let customer = customer {
                    self.order?.customer = customer
                    self.textFieldCustomer.text = customer.name!
                }
            }

        case "orderToRowOfOrder":
            let controller = segue.destination as! RowOfOrderViewController
            controller.rowOfOrder = sender as? RowOfOrder

        default:
            break
        }
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = table?.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowOfOrder = table?.object(at: indexPath as IndexPath) as! RowOfOrder
        let cell = UITableViewCell()
        let nameOfService = (rowOfOrder.service == nil) ? "-- Unknown --" : (rowOfOrder.service!.name!)
        cell.textLabel?.text = nameOfService + " - " + String(rowOfOrder.sum)
        return cell
    }
    
    // MARK: - Table View Delegate
    
    private func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .delete {
            let managedObject = table?.object(at: indexPath as IndexPath) as! NSManagedObject
            CoreDataManager.instance.managedObjectContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let rowOfOrder = table?.object(at: indexPath as IndexPath) as! RowOfOrder
        performSegue(withIdentifier: "orderToRowOfOrder", sender: rowOfOrder)
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
                let rowOfOrder = table?.object(at: indexPath as IndexPath) as! RowOfOrder
                let cell = tableView.cellForRow(at: indexPath as IndexPath)!
                let nameOfService = (rowOfOrder.service == nil) ? "-- Unknown --" : (rowOfOrder.service!.name!)
                cell.textLabel?.text = nameOfService + " - " + String(rowOfOrder.sum)
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
