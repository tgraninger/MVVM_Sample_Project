//
//  BucketItemsViewModel.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation

protocol BucketItemsViewModelDelegate: class {
	func reloadData()
}

class BucketItemsViewModel {
	
	var selectedCategory: BLCategoryMO!
	var dataStore: [BLItemMO]?
	var hasItems: Bool!
	
	weak var delegate: BucketItemsViewModelDelegate!
	
	func setItems() {
		guard let items = Array(selectedCategory.items!) as? [BLItemMO] else { return }
		
		for item in items {
			print(item.name)
		}
		
		if items.count < 0 {
			hasItems = true
			dataStore = items
		} else {
			hasItems = false
		}
		
		delegate.reloadData()
	}
}
