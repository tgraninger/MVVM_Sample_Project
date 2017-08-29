//
//  ImageSearchClient.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/29/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation

protocol ImageSearchClientDelegate: class {
	func setImages(_ images: [String]?)
}

class ImageSearchClient {
	
	weak var delegate: ImageSearchClientDelegate!
	
	func fetchImagesForItem(_ itemName: String) {
		
		let baseUrl = "https://pixabay.com/api/?key=5413279-0c9ea709391f91ed9ab8c1561&q=\(itemName)&image_type=photo"
		
		let urlPath = baseUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
		
		let url = URL(string: urlPath!)
		
		var request = URLRequest(url: url!)
		
		request.httpMethod = "GET"
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			
			guard let responseData: Data = data, error == nil
				else { return }
			
			guard let json = try? JSONSerialization.jsonObject(with: responseData, options: []) as! [String : AnyObject]
				else { return }
			
			let hits = json["hits"] as! [AnyObject]
			
			var images = [String]()
			
			for item in hits {
				images.append(item["webformatURL"] as! String)
			}
			
			DispatchQueue.main.async {
				if images.count != 0 {
					self.delegate.setImages(images)
				} else {
					self.delegate.setImages(nil)
				}
			}
		}
		task.resume()
	}
	
}
