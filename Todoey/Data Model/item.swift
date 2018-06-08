//
//  Model.swift
//  Todoey
//
//  Created by Denis Garifyanov on 08/06/2018.
//  Copyright © 2018 Denis Garifyanov. All rights reserved.
//

import Foundation

class Item {
    static var counterOfItem = 1
    var title = "New Item"
    var doneStatus = false
    init (){
        title = "New Item"
        doneStatus = false
    }
    init(number: Int) {
        title = "New Item \(number)"
        doneStatus = false
    }
    
    init(withTitle: String) {
        title = withTitle
        doneStatus = false
    }
}
