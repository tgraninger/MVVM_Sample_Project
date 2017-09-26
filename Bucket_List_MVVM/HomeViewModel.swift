//
//  HomeViewModel.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 9/15/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: class {
	func setItems()
	func updateDataStore()
}

class HomeViewModel {
	
	weak var delegate: HomeViewModelDelegate!
	var filter: Filter = .Items
	var buckets: [BLCategoryMO]!
	var items: [BLItemMO]!
	
	func fetchBuckets() {
		let client = CoreDataClient()
		
		client.delegate = self
		
		client.fetchCategories()
	}
}

extension HomeViewModel: CoreDataClientDelegate {
	
	func setCategories(_ categories: [BLCategoryMO]) {
		buckets = categories
		
		for bucket in categories {
			let itemsSet = bucket.items ?? []
			let itemsArray: [BLItemMO]! = Array(itemsSet) as? [BLItemMO]
			
			items = items ?? [BLItemMO]()
			
			items.append(contentsOf: itemsArray)
		}
		
		delegate.setItems()
	}
}
