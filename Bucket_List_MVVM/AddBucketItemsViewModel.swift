//
//  AddBucketItemsViewModel.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation

protocol AddBucketItemViewModelDelegate: class {
	func nameValidated(_ success: Bool)
}

class AddBucketItemViewModel {
	
	weak var delegate: AddBucketItemViewModelDelegate!
	var selectedCategory: BLCategoryMO!
	var newItem: BLItemMO?
	
	func setNameFieldText() -> String {
		guard let newItem = newItem else {
			return ""
		}
		
		guard let name = newItem.name else {
			return ""
		}
		
		return name
	}
	
	func createNewItem(_ name: String) {
		let client = CoreDataClient()
		
		client.delegate = self
		
		client.insertObject(["name" : name, "category" : selectedCategory, "completed" : false], entityName: "BLItemMO")
	}
	
	func setName(_ name: String?) {
		guard let name = name else {
			delegate.nameValidated(false)
			return
		}
		
		delegate.nameValidated(true)
		
		guard let newItem = newItem  else {
			createNewItem(name)
			return
		}
		
		newItem.name = name
	}
	
	func saveItem() {
		guard let newItem = newItem else { return } //Should throw alert
		
		selectedCategory.addToItems(newItem)
		
		let client = CoreDataClient()
		
		client.saveChanges()
	}
}

extension AddBucketItemViewModel: CoreDataClientDelegate {
	
	func addedItem(_ item: BLItemMO) {
		newItem = item
		
		delegate.nameValidated(true)
	}
}


