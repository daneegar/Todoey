//
//  ViewController.swift
//  Todoey
//
//  Created by Denis Garifyanov on 05/06/2018.
//  Copyright © 2018 Denis Garifyanov. All rights reserved.
//

import UIKit

class TableTodoViewController: UITableViewController {
    var todoItems = ["Buy eggs", "Buy machine", "make project"]
    var LocalBase = UserDefaults.standard
    override func viewDidLoad() {
        if let baseMaked = LocalBase.array(forKey: "TodoItemsList") as? [String]{
            todoItems = baseMaked
        }
        super.viewDidLoad()
    }
    
    //MARK: table initialisation
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.text = todoItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    //MARK: Table view selecting method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  tableView.cellForRow(at: indexPath)!.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)!.accessoryType = .none
        } else {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    
    //MARK: Add Item aciton decloration
    @IBAction func AddItem(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        
        let alertForNameanItem = UIAlertController(title: "Add Item", message: "Name the deal", preferredStyle: .alert)
        
        let alertButtonPressed = UIAlertAction(title: "Add", style: .default) { (Alert) in
            if alertTextField.text == "" {
                self.todoItems.append("New Item")
            } else {
                self.todoItems.append(alertTextField.text!)
            }
            self.LocalBase.set(self.todoItems, forKey: "TodoItemsList")
            self.tableView.reloadData()
        }
        alertForNameanItem.addAction(alertButtonPressed)
        
        alertForNameanItem.addTextField { (AlertTextInput) in
            AlertTextInput.placeholder = "Here..."
            alertTextField = AlertTextInput
        }
        present(alertForNameanItem, animated: true)
        
        
        
    }
    
}

