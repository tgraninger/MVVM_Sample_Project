//
//  CategoriesViewController.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	var viewModel: CategoriesViewModel!
	
	// MARK: - Life Cycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		viewModel = CategoriesViewModel()
		
		viewModel.delegate = self
		
		self.edgesForExtendedLayout = []
		self.automaticallyAdjustsScrollViewInsets = false
    }
	
	override func viewDidAppear(_ animated: Bool) {
		viewModel.fetchCategories()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "pushItemsViewController" {
			let viewController = segue.destination as! BucketItemsViewController
			
			let selectedIndexPath: IndexPath = tableView.indexPathForSelectedRow!
			let selectedCategory = viewModel.dataStore![selectedIndexPath.row]
			
			viewController.viewModel = BucketItemsViewModel()
			viewController.viewModel.selectedCategory = selectedCategory
		}
    }

}

// MARK: - Table View Data Source

extension CategoriesViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.dataStore?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CATEGORY_CELL", for: indexPath)
		
		let category: BLCategoryMO = viewModel.dataStore![indexPath.row]
		
		cell.textLabel?.text = category.name
		
		return cell
	}
}

// MARK: - Table View Delegate

extension CategoriesViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "pushItemsViewController", sender: self)
	}
}

// MARK: - View Model Delegate

extension CategoriesViewController: CategoriesViewModelDelegate {
	
	func reloadData() {
		tableView.reloadData()
	}
}
