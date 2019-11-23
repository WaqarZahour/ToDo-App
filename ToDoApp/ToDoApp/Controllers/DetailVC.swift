//
//  DetailVC.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 10/4/17.
//  Copyright © 2017 Waqar Zahour. All rights reserved.
//

import UIKit

protocol DBObjectModify: class {
    func refreshUI()
}

class DetailVC: UIViewController {

    // MARK: IBOutlet and Other Properties
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    var priorities = [String]()
    var todo: Todo?
    weak var delegate: DBObjectModify?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        for priority in Priorities.allCases {
            priorities.append(priority.rawValue)
        }
        
        guard let todo = todo else {
            deleteButton.isHidden = true
            return
        }
        
        nameField.text = todo.name
        pickerView.selectRow(priorities.firstIndex(of: todo.priority) ?? 0, inComponent: 0, animated: true)
    }
    
    deinit {
        print("DetailVC de-initialized")
    }
    
    // MARK: Button Actions
    /// In this function move back to the main screen
    ///
    /// - Parameters
    ///     sender: pass button reference
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /// In this function we'll delete the current todo item
    ///
    /// - Parameters
    ///     sender: pass button reference
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if let todo = todo {
            DataLayer.instance.delete(todo: todo)
            delegate?.refreshUI()
        }
        dismiss(animated: true, completion: nil)
    }
    
    /// In this function we'll save or update the todo item
    ///
    /// - Parameters
    ///     sender: pass button reference
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let nameText = nameField.text, !nameText.isEmpty else {
            self.showAlert(title: ERRORMESSAGE, message: NAMEERROR)
            return
        }
        
        if let todo = todo {
            let dict = [NAME: nameField.text ?? "", PRIORITY: priorities[pickerView.selectedRow(inComponent: 0)]]
            DataLayer.instance.update(todo: todo, dataDict: dict)
        } else {
            let todo = Todo()
            todo.name = nameField.text ?? ""
            todo.priority = priorities[pickerView.selectedRow(inComponent: 0)]
            todo.createdDate = Date()
            DataLayer.instance.create(todo: todo)
        }
        delegate?.refreshUI()
        dismiss(animated: true, completion: nil)
    }
}

extension DetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: PickerView - Delegate and Datasource
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorities.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // update when seelcted
    }
}
