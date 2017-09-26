//
//  UserDefaultsManager.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 9/18/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation

class UserDefaultsManager {
	
	static let sharedInstance = UserDefaultsManager()
	
	var filter: String?
//	{
//		get {
//			guard let filter = UserDefaults.standard.value(forKey: "savedFilter") as? String else {
//				return nil
//			}
//			return filter
//		} set {
//			UserDefaults.standard.set(Filter(rawValue: newValue), forKey: "savedFilter")
//		}
//	}
}
