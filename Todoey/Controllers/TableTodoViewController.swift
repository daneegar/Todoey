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
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let LocalBase = UserDefaults()
    
    
    override func viewDidLoad() {
        
        readData()
        print(dataFilePath)
        
        
        
//        if let baseMaked = LocalBase.array(forKey: "TodoItemsList") as? [Item]{
//            todoItems = baseMaked
//        }
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
        setDate()
        
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
            
            self.setDate()
            

        }
        alertForNameanItem.addAction(alertButtonPressed)

        alertForNameanItem.addTextField { (AlertTextInput) in
            AlertTextInput.placeholder = "Here..."
            alertTextField = AlertTextInput
        }
        present(alertForNameanItem, animated: true)



    }
    func setDate (){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(todoItems)
            try data.write(to: dataFilePath!)
        } catch{
            print ("error encoding item array, \(error)")
        }
        tableView.reloadData()
    }
    
    func readData(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                 try todoItems = decoder.decode([Item].self, from: data)
            } catch {
                print("error decoding item array, \(error)")
            }
        }
        
    }
}

