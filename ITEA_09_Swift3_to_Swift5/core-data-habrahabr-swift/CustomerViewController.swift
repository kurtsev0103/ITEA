//
//  CustomerViewController.swift
//  core-data-habrahabr-swift

import UIKit

class CustomerViewController: UIViewController {

    var customer: Customer?
    
    @IBAction func cancel(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(sender: AnyObject) {
        if saveCustomer() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Reading object
        if let customer = customer {
            nameTextField.text = customer.name
            infoTextField.text = customer.info
        }
    }
    
    func saveCustomer() -> Bool {
        
        // Validation of required fields
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Input the name of the Customer!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        // Creating object
        if customer == nil {
            customer = Customer()
        }
        
        // Saving object
        if let customer = customer {
            customer.name = nameTextField.text
            customer.info = infoTextField.text
            CoreDataManager.instance.saveContext()
        }
        
        return true
    }
}
