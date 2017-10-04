//
//  ToDo.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 10/4/17.
//  Copyright © 2017 Waqar Zahour. All rights reserved.
//

import Foundation
import RealmSwift

// Todo model
class Todo: Object {
    dynamic var name = ""
    dynamic var priority = ""
    dynamic var dateCreated = Date(timeIntervalSince1970: 1)
}
