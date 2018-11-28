//
//  CommonFunctions.swift
//  todoList
//
//  Created by rishad k on 28/11/18.
//  Copyright © 2018 Riley Norris. All rights reserved.
//

import Foundation
import Alamofire
struct NetworkFunctions {
    
    static func NetworkRechability() -> Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
}
