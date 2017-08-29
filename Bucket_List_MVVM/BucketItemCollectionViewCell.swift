//
//  BucketItemCollectionViewCell.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit

class BucketItemCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var itemImageView: UIImageView!
	@IBOutlet weak var itemNameLabel: UILabel!
	
	func setCellData(_ imageUrlString: String?, itemName: String) {
		self.itemNameLabel.text = itemName
		
		if imageUrlString != nil {
			self.itemImageView.imageFromUrl(imageUrlString!)
		}
	}
    
}
