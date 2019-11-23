//
//  Date+Extension.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 22/11/2019.
//  Copyright © 2019 Waqar Zahour. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let created: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }()
}
