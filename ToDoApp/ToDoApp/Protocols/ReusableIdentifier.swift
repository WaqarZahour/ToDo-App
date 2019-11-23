//
//  ReusableIdentifier.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 23/11/2019.
//  Copyright © 2019 Waqar Zahour. All rights reserved.
//

import Foundation

protocol ReusableIdentifier {
    static var reuseIdentifier: String { get }
}

extension ReusableIdentifier {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
