//
//  UITableView.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 23/11/2019.
//  Copyright © 2019 Waqar Zahour. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Override dequeueReusableCell with T type means that could be any type of cell
    /// - Parameters:
    ///   - indexPath: array of the index for each cell
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell")
        }
        return cell
    }
}
