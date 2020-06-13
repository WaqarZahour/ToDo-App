//
//  ViewController.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 10/4/17.
//  Copyright © 2017 Waqar Zahour. All rights reserved.
//

import UIKit
import RealmSwift

class TodoVC: UIViewController {

    // MARK: IBOutlet and Other Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var todos: Results<Todo>?
    var isSearchMode = false
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        todos = DataLayer.instance.getAll()
        todos = todos?.sorted(byKeyPath: CREATEDDATE, ascending: false)
    }

    deinit {
        print("TodoVC de-initialized")
    }
    
    /// In a storyboard-based application, you will often want to do a little preparation before navigation
    ///
    /// - Parameters:
    ///   - segue: to navigate from one screen to antother
    ///   - sender: is todo object
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DetailVC.reuseIdentifier {
            if let destination = segue.destination as? DetailVC {
                if let todo = sender as? Todo {
                    destination.todo = todo
                }
                destination.delegate = self
            }
        }
    }
    
    // MARK: Button Actions
    /// This function called when user press on the + button
    ///
    /// - Parameters
    ///     sender: pass button reference
    @IBAction func addNewTask(_ sender: Any) {
        performSegue(withIdentifier: DetailVC.reuseIdentifier, sender: nil)
    }
    
    /// In this fucntions when segment change the value sort todos accordingly
    ///
    /// - Parameters
    ///     sender: pass segemented control reference
    @IBAction func segmentChange(_ sender: AnyObject) {
        let filter = Filter(rawValue: segment.selectedSegmentIndex)
        switch filter {
        case .createdDate:
            todos = todos?.sorted(byKeyPath: CREATEDDATE, ascending: false)
        case .priority:
            todos = todos?.sorted(byKeyPath: PRIORITY, ascending: true)
        default:
            break
        }
        tableView.reloadData()
    }
}

extension TodoVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: TableView Delegate and Data Source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TodoCell = tableView.dequeueReusableCell(for: indexPath)
        if let todos = todos {
            cell.configureCell(todo: (todos[indexPath.row]))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let todos = todos else {
            return 0
        }
        return todos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let todos = todos {
            performSegue(withIdentifier: DetailVC.reuseIdentifier, sender: (todos[indexPath.row]))
        }
    }
}

extension TodoVC: UISearchBarDelegate {
    // MARK: SearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            isSearchMode = false
            todos = DataLayer.instance.getAll()
            tableView.reloadData()
            view.endEditing(true)
            return
        }
        
        isSearchMode = true
        todos = DataLayer.instance.filterByName(searchText: searchText)
        tableView.reloadData()
    }
}

extension TodoVC: DBObjectModify {
    // MARK: DBObjectModiy Delegate
    func refreshUI() {
        self.tableView.reloadData()
    }
}
