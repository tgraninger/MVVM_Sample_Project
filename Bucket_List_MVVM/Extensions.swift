//
//  Extensions.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit

extension UIImageView {
	
	public func imageFromUrl(_ urlString: String) {
		URLSession.shared.dataTask(with: URL(string: urlString)! as URL, completionHandler: { (data, response, error) in
			if error != nil {
				return
			}
			
			DispatchQueue.main.async(execute: { () -> Void in
				let image = UIImage(data: data!)
				self.image = image
			})
		}).resume()
	}
}

extension NSDate {
	
	func formatDate(_ date: NSDate) -> String {
		let dateFormatter = DateFormatter()
		
		dateFormatter.dateFormat = "MM/dd/YY"
		
		return dateFormatter.string(from: date as Date)
	}
}
