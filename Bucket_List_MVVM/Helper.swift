//
//  Helper.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/30/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation

class Helper {
	
	func sort(_ array: [Any]) -> [Any] {
		if let array = array as? [BLItemMO] {
			return array.sorted { $0.dateAdded!.compare($1.dateAdded! as Date) == .orderedAscending }
		}
		
		return array
	}
}
