//
//  TodoCell.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 10/4/17.
//  Copyright © 2017 Waqar Zahour. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    // MARK: IBOoutlet Properties
    @IBOutlet weak var todoNameLabel: UILabel!
    @IBOutlet weak var todoPriorityLabel: UILabel!
    @IBOutlet weak var todoDateLabel: UILabel!
    
    // MARK: Cell Customization
    /// Customize cell for each row
    ///
    /// - Parameters 
    ///     todo: object of the Todo Model
    func configureCell(todo: Todo) {
        todoNameLabel.text = todo.name
        todoPriorityLabel.text = "Priority: \(todo.priority)"
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        todoDateLabel.text = "Created At: \(formatter.string(from: todo.createdDate))"
    }
}
