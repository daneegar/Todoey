//
//  ViewController.swift
//  Todoey
//
//  Created by Denis Garifyanov on 05/06/2018.
//  Copyright © 2018 Denis Garifyanov. All rights reserved.
//

import UIKit
import CoreData

class TableTodoViewController: UITableViewController {
    var todoItems = [Item]()
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let LocalBase = UserDefaults()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        
         readData()
        //print(dataFilePath)
        
        
        
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
        setData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK: Add Item aciton decloration
    @IBAction func AddItem(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        
        let alertForNameanItem = UIAlertController(title: "Add Item", message: "Name the deal", preferredStyle: .alert)

        let alertButtonPressed = UIAlertAction(title: "Add", style: .default) { (Alert) in
            if alertTextField.text == "" {
                self.todoItems.append(Item(insertIntoManagesObjectContext: self.context))
            } else {
                self.todoItems.append(Item(withTitle: alertTextField.text!, insertIntoManagesObjectContext: self.context))
            }
            
            self.setData()
            

        } 
        alertForNameanItem.addAction(alertButtonPressed)

        alertForNameanItem.addTextField { (AlertTextInput) in
            AlertTextInput.placeholder = "Here..."
            alertTextField = AlertTextInput
        }
        present(alertForNameanItem, animated: true)



    }
    func setData (){
        do{
            try context.save()
        } catch{
            print ("setting data error, \(error)")
        }
        tableView.reloadData()
    }
    
    func readData(wia request: NSFetchRequest<Item> = Item.fetchRequest()){
        //let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            todoItems = try context.fetch(request)
        } catch {
            print("loading data error, \(error)")
        }
        tableView.reloadData()
    }
}
//MARK - Searching fich
extension TableTodoViewController: UISearchBarDelegate{
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate (format: "title CONTAINS[cd] %@", searchBar.text!)
         request.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        if searchBar.text! != ""{
            readData(wia: request)
        } else {
            readData()
        }
    }
}



















