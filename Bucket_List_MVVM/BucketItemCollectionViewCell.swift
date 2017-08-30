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
	@IBOutlet weak var itemDateLabel: UILabel!
	
	func setCellData(_ item: BLItemMO) {
		self.itemNameLabel.text = item.name
		
		if item.imageString != nil {
			self.itemImageView.imageFromUrl(item.imageString!)
		}
		
		if item.dateCompleted != nil {
			self.itemDateLabel.text = item.dateCompleted!.formatDate(item.dateCompleted!)
		} else {
			self.itemDateLabel.text = item.dateAdded!.formatDate(item.dateAdded!)
		}
	}
}
