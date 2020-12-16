//
//  ViewController.swift
//  DemoApp
//
//  Created by Cecilia Valenti on 2020-12-15.
//

import UIKit

class ViewController: UITableViewController {
    
    let networkHandler = NetworkHandler()

    var dataModel: ManagerDataModel?
    var searchResults: [ManagerDataModel.Manager] = []
    var numberOfResults: Int { searchResults.count }

    let cellIdentifier = "searchResultCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        setupSearchBar()
        networkHandler.fetch()

        networkHandler.callback = { [weak self] managerList in

            //Create datamodel from json
            self?.dataModel = .init(dto: managerList)
            if let managers = self?.dataModel?.managers {
                self?.searchResults = managers
            }
            self?.tableView?.reloadData()
        }
    }

    private func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }

}

// MARK: Tableview methods
extension ViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfResults
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
            return UITableViewCell()
        }

        let text = "\(searchResults[indexPath.row].name) - \(searchResults[indexPath.row].email)"
        cell.textLabel?.text = text

        return cell
    }
}

extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text == "" {
            if let managers = dataModel?.managers {
                searchResults = managers
            }
        } else {
            print("Searching for text: \(text)")
            searchResults = checkForMatches(for: text)
            print("Found \(searchResults.count) matches")
        }

        tableView.reloadData()
    }

    private func checkForMatches(for searchString: String) -> [ManagerDataModel.Manager] {
        guard let dataModel = dataModel else { return [] }
        let result: [ManagerDataModel.Manager] = dataModel.managers.compactMap { manager in
            if manager.name.lowercased().contains(searchString.lowercased()) ||
                manager.email.contains(searchString.lowercased()) {
                return manager
            }
            return nil
        }
        return result
    }
}
