//
//  DataLayer.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 10/4/17.
//  Copyright © 2017 Waqar Zahour. All rights reserved.
//

import Foundation
import RealmSwift

class DataLayer {
    // MARK: Singleton Implemention
    static let instance = DataLayer()
    private init(){}
    
    let realm = try! Realm()
    
    // MARK: Crud operations
    /// In this function will return all the todos
    ///
    /// - Returns: list of all todos
    func getAll() -> Results<Todo>? {
        return realm.objects(Todo.self)
    }
    
    /// In this function will return the todos on the basis of search text
    ///
    /// - Parameters
    ///     - searchText: name you want to search
    /// - Returns: list of filter todos
    func filterByName(searchText: String) -> Results<Todo>? {
        return realm.objects(Todo.self).filter("name contains '\(searchText)'")
    }
    
    /// In this fucntion we'll create todo object and save it in the database
    ///
    /// - Parameters:
    ///     - todo: object of Todo Class
    func create(todo:Todo) {
        try! realm.write {
            realm.add(todo)
        }
    }
    
    /// In this fucntion we'll delete todo object and save it in the database
    ///
    /// - Parameters:
    ///     - todo: object of Todo Class
    func delete(todo:Todo) {
        try! realm.write {
            realm.delete(todo)
        }
    }

    /// In this fucntion we'll update todo object and save it in the database
    ///
    /// - Parameters:
    ///     - todo: object of Todo Class
    func update(todo:Todo, dataDict: Dictionary<String, Any>) {
        try! realm.write {
            todo.name = (dataDict[NAME] as? String)!
            todo.priority = (dataDict[PRIORITY] as? String)!
        }
    }
}
