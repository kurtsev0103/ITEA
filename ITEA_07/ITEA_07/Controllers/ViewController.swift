//
//  ViewController.swift
//  ITEA_07
//
//  Created by Oleksandr Kurtsev on 15/05/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var context: NSManagedObjectContext!
    var contacts: [NSManagedObject] = []
    let segueToNewContact = "goToAddContact"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Запрос на получение всех объектов по entity "Contact"
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        //Сортировка
        let nameSort = NSSortDescriptor(key:"name", ascending:true)
        fetchRequest.sortDescriptors = [nameSort]
        
        //Получение объектов
        do {
            contacts = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactTableViewCell.nib(), forCellReuseIdentifier: ContactTableViewCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToNewContact {
            let newVC = segue.destination as! NewContactViewController
            newVC.context = context
            newVC.delegate = self
        }
    }
    
    @IBAction func deleteAllObjects(_ sender: UIBarButtonItem) {
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        if let results = try? context.fetch(fetchRequest) {
            for obj in results {
                context.delete(obj)
            }
        }
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        contacts.removeAll()
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        
        cell.configure(with: contacts[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(contacts[indexPath.row])
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

//MARK: - AddContactDelegate

extension ViewController: AddContactDelegate {
    
    func addContact(contact: NSManagedObject) {
        self.contacts.append(contact)
        self.tableView.reloadData()
    }
}

