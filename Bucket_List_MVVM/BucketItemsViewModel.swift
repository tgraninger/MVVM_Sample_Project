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
	
	var dataStore: [BLItemMO]?
	
	weak var delegate: BucketItemsViewModelDelegate!
	
	func setItems() {
		guard let items = dataStore else { return }
		
		if items.count != 0 {
			dataStore = Helper().sort(items) as? [BLItemMO]
		}
		
		delegate.reloadData()
	}
}
