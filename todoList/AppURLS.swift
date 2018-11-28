//
//  AppURLS.swift
//  todoList
//
//  Created by rishad k on 28/11/18.
//  Copyright © 2018 Riley Norris. All rights reserved.
//



import Foundation
import Alamofire
public let HOSTNAME = "http://209.97.130.200:5000"



struct AppURLS {
    public static let TASK_LIST_UEL = "\(HOSTNAME)/todo/TodoListWithStatus"
    public static let CREATE_TASK_UEL = "\(HOSTNAME)/todo/CreateTodo"
    public static let DELETE_TASK_UEL = "\(HOSTNAME)/todo/todoRemove"
    public static let MAKE_AS_COMPLETE_TASK_UEL = "\(HOSTNAME)/todo/MakeAsComplete"
    public static let UPDATE_TASK_NAME_UEL = "\(HOSTNAME)/todo/ChangeName"
    
}






