//
//  Todo.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 01/11/2019.
//  Copyright © 2019 Waqar Zahour. All rights reserved.
//

import Foundation
import RealmSwift

// Todo model
class Todo: Object {
    @objc dynamic var name = ""
    @objc dynamic var priority = ""
    @objc dynamic var createdDate = Date(timeIntervalSince1970: 1)
}
