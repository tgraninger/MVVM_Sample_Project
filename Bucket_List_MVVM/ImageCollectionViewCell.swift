//
//  ImageCollectionViewCell.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/29/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var aImageView: UIImageView!
	
	func setImage(_ urlString: String) {
		self.aImageView.imageFromUrl(urlString)
	}
}
