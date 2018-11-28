//
//  Task.swift
//  todoList
//
//  Created by rishad k on 28/11/18.
//  Copyright © 2018 Riley Norris. All rights reserved.
//

import Foundation

class Tasks {
    var name = ""
    var checked = false
    var id = 0
    convenience init (name: String,checked:Bool,id:Int) {
        self.init()
        self.name = name
        self.checked = checked
        self.id = id
    }
    
    func validTaskName()->Bool
    {
        return (name.count) > 0
    }
    
}
