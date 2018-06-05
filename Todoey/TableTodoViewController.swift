//
//  ViewController.swift
//  Todoey
//
//  Created by Denis Garifyanov on 05/06/2018.
//  Copyright © 2018 Denis Garifyanov. All rights reserved.
//

import UIKit

class TableTodoViewController: UITableViewController {
let todoItems = ["Buy eggs", "Buy machine", "make project"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.text = todoItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  tableView.cellForRow(at: indexPath)!.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)!.accessoryType = .none
        } else {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
//    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//
//        if  tableView.cellForRow(at: indexPath)!.accessoryType == UITableViewCellAccessoryType.checkmark {
//            tableView.cellForRow(at: indexPath)!.accessoryType = UITableViewCellAccessoryType.none
//            return indexPath
//        } else {
//            print ("Select")
//
//
//            return indexPath
//        }
//
//    }
    override func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        print ("Will Deselect")
        return indexPath
    }
    

}

