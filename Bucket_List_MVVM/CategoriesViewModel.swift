//
//  CategoryViewModel.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation

protocol CategoriesViewModelDelegate: class {
	func reloadData()
}

class CategoriesViewModel {
	
	weak var delegate: CategoriesViewModelDelegate!
	var dataStore: [BLCategoryMO]?
	
	func fetchCategories() {
		let client = CoreDataClient()
		
		client.delegate = self
		
		client.fetchCategories()
	}
}

extension CategoriesViewModel: CoreDataClientDelegate {
	
	func setCategories(_ categories: [BLCategoryMO]) {
		dataStore = categories
				
		delegate.reloadData()
	}
}
