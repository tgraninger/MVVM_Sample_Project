//
//  AlertView.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/29/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit

class AlertView: UIAlertController {
	
	let t = "Empty Fields"
	let m = "Please complete all fields."
	
	func alert() -> UIAlertController {
		let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
		
		let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		
		alert.addAction(action)
		
		return alert
	}
}
