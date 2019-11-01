//
//  Constant.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 10/4/17.
//  Copyright © 2017 Waqar Zahour. All rights reserved.
//

import Foundation

let CREATED_DATE = "createdDate"
let ERROR_MESSAGE = "Error Message"
let NAME = "name"
let NAME_ERROR = "Please enter the name"
let OKAY = "Okay"
let PRIORITY = "priority"

enum Identifier: String {
    case TodoCell
    case DetailVC
}

enum Filter: Int {
    case CreatedDate = 0
    case Priority
}
