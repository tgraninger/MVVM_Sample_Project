//
//  AddImageViewModel.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation

protocol AddImageViewModelDelegate: class {
	func reloadData()
	func dismissViewController()
}

class AddImageViewModel {
	
	weak var delegate: AddImageViewModelDelegate!

	var newItem: BLItemMO!
	var dataStore: [String]?
	
	func fetchImages() {
		let client = ImageSearchClient()
		
		client.delegate = self
		
		client.fetchImagesForItem(newItem.name!)
	}
	
	func setImage(_ index: Int) {
		newItem.imageString = dataStore![index]
		
		delegate.dismissViewController()
	}
}

extension AddImageViewModel: ImageSearchClientDelegate {
	
	func setImages(_ images: [String]?) {
		if images == nil {
			// Alert
		} else {
			dataStore = images
			delegate.reloadData()
		}
	}
}
