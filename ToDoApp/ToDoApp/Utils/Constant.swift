//
//  Constant.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 10/4/17.
//  Copyright © 2017 Waqar Zahour. All rights reserved.
//

import Foundation

let CREATEDDATE = "createdDate"
let ERRORMESSAGE = "Error Message"
let NAME = "name"
let NAMEERROR = "Please enter the name"
let OKAY = "Okay"
let PRIORITY = "priority"

// Cell and StoryBoard Identifier
enum Identifier: String {
    case todoCell = "TodoCell"
    case detailVC = "DetailVC"
}

// Filter on the basis of priority and date
enum Filter: Int {
    case createdDate = 0
    case priority
}

// Types of Priority
enum Priorities: String, CaseIterable {
    case low = "Low"
    case intermediate = "Intermediate"
    case high = "High"
}
