//
//  AddCategoryViewModel.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation

protocol AddCategoryViewModelDelegate: class {
	func presentAlertForEmptyFields()
	func successfullyStoredObject()
	func failedToStoreObject()
}

class AddCategoryViewModel {
	
	weak var delegate: AddCategoryViewModelDelegate!
	
	func addCategory(_ name: String?) {
		guard let name = name else {
			delegate.presentAlertForEmptyFields()
			return
		}
		
		let newCategory: [String : Any] = ["name" : name]
		
		let client = CoreDataClient()
		
		client.delegate = self
		
		client.insertObject(newCategory, entityName: "BLCategoryMO")
	}
}

extension AddCategoryViewModel: CoreDataClientDelegate {
	
	func addedObject(_ success: Bool) {
		if success {
			delegate.successfullyStoredObject()
		} else {
			delegate.failedToStoreObject()
		}
	}
}
