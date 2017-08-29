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
		let data = ["Venues", "Places", "Museums", "Films", "Restaurants"]
		var defaultValues = [BLCategoryMO]()
		
		for i in 0...4 {
			let context = getContext()
			
			let entity =  NSEntityDescription.entity(forEntityName: "BLCategoryMO", in: context)
			
			let category = NSManagedObject(entity: entity!, insertInto: context)
			
			category.setValue(data[i], forKey: "name")
			
			saveChanges(context, completion: { 
				defaultValues.append(category as! BLCategoryMO)
			})
		}
		delegate.setCategories!(defaultValues)
	}
	
	func insertObject(_ newObject: [String : Any], entityName: String) {
		let context = getContext()
		
		let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
		
		let object = NSManagedObject(entity: entity!, insertInto: context)
		
		object.setValue(newObject["name"], forKey: "name")
		
		if entityName == "BLItemMO" {
			delegate.addedItem!(object as! BLItemMO)
		}
	}
	
	func saveChanges(_ context: NSManagedObjectContext?, completion: (() -> Void)? = nil) {
		let context = context ?? getContext()
		
		do {
			try context.save()
		} catch {
			return
		}
	}
}
