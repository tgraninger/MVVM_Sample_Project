//
//  CoreDataClient.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit
import CoreData

@objc protocol CoreDataClientDelegate: class {
	@objc optional func setCategories(_ categories: [BLCategoryMO])
	@objc optional func addedItem(_ item: BLItemMO)
}

class CoreDataClient {
	
	weak var delegate: CoreDataClientDelegate!
	
	func fetchCategories() {
		let fetchRequest: NSFetchRequest<BLCategoryMO> = BLCategoryMO.fetchRequest()
		
		do {
			let categories = try getContext().fetch(fetchRequest)
			
			if categories.count == 0 {
				setDefaultValues()
			} else {
				delegate.setCategories!(categories)
			}
		} catch {
			print("Error with request: \(error)")
		}
	}
	
	func getContext () -> NSManagedObjectContext {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		return appDelegate.persistentContainer.viewContext
	}
	
	func setDefaultValues() {
		let data = [["name" : "Countries"], ["name" : "Venues"], ["name" : "Restaurants"]]
		var defaultValues = [BLCategoryMO]()
		
		for i in 0...2 {
			let context = getContext()
			
			let entity =  NSEntityDescription.entity(forEntityName: "BLCategoryMO", in: context)
			
			let category = NSManagedObject(entity: entity!, insertInto: context)
			
			category.setValue(data[i]["name"], forKey: "name")
						
			saveChanges()
			
			defaultValues.append(category as! BLCategoryMO)
		}
		delegate.setCategories!(defaultValues)
	}
	
	func insertObject(_ newObject: [String : Any], entityName: String) {
		let context = getContext()
		
		let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
		
		let object = NSManagedObject(entity: entity!, insertInto: context)
		
		object.setValue(newObject["name"], forKey: "name")
		
		if entityName == "BLItemMO" {
			object.setValue(newObject["category"], forKey: "category")
			object.setValue(Date(), forKey: "dateAdded")
			
			delegate.addedItem!(object as! BLItemMO)
		}
	}
	
	func saveChanges() {
		let context = getContext()
		
		do {
			try context.save()
		} catch {
			return
		}
	}
}
