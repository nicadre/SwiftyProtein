//
//  ProteinListViewController.swift
//  SwiftyProtein
//
//  Created by Nicolas Chevalier on 18/07/16.
//  Copyright © 2016 Nicolas CHEVALIER. All rights reserved.
//

import UIKit

class ProteinListViewController: UITableViewController {

	let data: NSDataAsset? = NSDataAsset(name: "ligandsList")

	var ligands: [String] = []
	var filteredLigands: [String] = []
	var shouldShowFilteredResults: Bool = false
	var searchController: UISearchController!

	override func viewDidLoad() {

		super.viewDidLoad()

		if let data = data?.data {
			if let ligand = String(data: data, encoding: NSUTF8StringEncoding) {
				ligands = ligand.componentsSeparatedByString("\n")
			}
		}

		configureSearchController()

	}

	func configureSearchController() {

		self.searchController = UISearchController(searchResultsController: nil)

		self.searchController.searchResultsUpdater = self
		self.searchController.searchBar.placeholder = "Search ligands ..."
		self.searchController.searchBar.delegate = self
		self.searchController.searchBar.sizeToFit()
		self.searchController.obscuresBackgroundDuringPresentation = false

		self.tableView.tableHeaderView = self.searchController.searchBar

	}

}


// MARK: - UISearchBarDelegate
extension ProteinListViewController: UISearchBarDelegate {

	func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
		self.shouldShowFilteredResults = true
		self.tableView.reloadData()
	}


	func searchBarCancelButtonClicked(searchBar: UISearchBar) {
		shouldShowFilteredResults = false
		self.tableView.reloadData()
	}

	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		if !shouldShowFilteredResults {
			shouldShowFilteredResults = true
			self.tableView.reloadData()
		}

		searchController.searchBar.resignFirstResponder()
	}


}

// MARK: - UISearchResultsUpdating
extension ProteinListViewController: UISearchResultsUpdating {

	func updateSearchResultsForSearchController(searchController: UISearchController) {
		let searchString = searchController.searchBar.text!

		if searchString.isEmpty {
			filteredLigands = ligands
		} else {
			filteredLigands = ligands.filter() { lig -> Bool in

				let ligand: NSString = lig

				return ligand.rangeOfString(searchString, options: .CaseInsensitiveSearch).location != NSNotFound

			}
		}

		self.tableView.reloadData()
	}

}

// MARK: - UITableView
extension ProteinListViewController {

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return shouldShowFilteredResults ? filteredLigands.count : ligands.count

	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		let tmp = tableView.dequeueReusableCellWithIdentifier("ligandsCell")
		if let cell = tmp as? LigandsListTableViewCell {
			cell.nameLabel.text = shouldShowFilteredResults ? filteredLigands[indexPath.row] : ligands[indexPath.row]
			return cell
		}

		return UITableViewCell()

	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		if UIApplication.sharedApplication().networkActivityIndicatorVisible == false {

			let name = shouldShowFilteredResults ? filteredLigands[indexPath.row] : ligands[indexPath.row]


			APIRequester.sharedInstance.requestLigand(name) { response in

				if let ligands = String(data: response.data!, encoding: NSUTF8StringEncoding)?.componentsSeparatedByString("\n") {

					var atomsList = [Atom]()

					var connectsList = [Connect]()

					for ligand in ligands {

						if let atom = Atom(atom: ligand) {
							atomsList.append(atom)
						}
						if let connect = Connect(data: ligand) {
							connectsList.append(connect)
						}

					}
					print(atomsList)
					print(connectsList)
				}

			}

		}

	}

}
