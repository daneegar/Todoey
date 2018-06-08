//
//  ViewController.swift
//  Todoey
//
//  Created by Denis Garifyanov on 05/06/2018.
//  Copyright © 2018 Denis Garifyanov. All rights reserved.
//

import UIKit

class TableTodoViewController: UITableViewController {
    var todoItems = [Item]()
    var LocalBase = UserDefaults.standard
    
    
    override func viewDidLoad() {
        for counter in 0...3  {
            todoItems.append(Item(number: counter))
        }
        
        
        
        if let baseMaked = LocalBase.array(forKey: "TodoItemsList") as? [Item]{
            todoItems = baseMaked
        }
        super.viewDidLoad()
        
    }
    
    //MARK: table initialisation
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        let loadedItem = todoItems[indexPath.row]
        
        cell.textLabel?.text = loadedItem.title
        cell.accessoryType = loadedItem.doneStatus ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    
    
    
    //MARK: Table view selecting method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        todoItems[indexPath.row].doneStatus = !todoItems[indexPath.row].doneStatus
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
    }
    
    
    //MARK: Add Item aciton decloration
    @IBAction func AddItem(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()

        let alertForNameanItem = UIAlertController(title: "Add Item", message: "Name the deal", preferredStyle: .alert)

        let alertButtonPressed = UIAlertAction(title: "Add", style: .default) { (Alert) in
            if alertTextField.text == "" {
                self.todoItems.append(Item())
            } else {
                self.todoItems.append(Item(withTitle: alertTextField.text!))
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

