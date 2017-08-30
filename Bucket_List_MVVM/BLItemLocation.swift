//
//  BLItemLocation.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/30/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation
import MapKit

class BLItemLocation {
	
	var placemark: CLPlacemark!
	
	init(_ placemark: CLPlacemark) {
		self.placemark = placemark
	}
	
	func setCoordinates() -> [String : Double]? {
		guard let placemark = placemark else { return nil }
		
		guard let location = placemark.location else { return nil }
		
		let lat = location.coordinate.latitude 
		let lng = location.coordinate.latitude 
		
		return ["latitude" : lat, "longitude": lng]
	}
	
	func setAddress() -> String {
		guard let placemark = placemark else { return "" }
		
		let address = placemark.thoroughfare ?? ""
		let locality = placemark.locality ?? ""
		let adminArea = placemark.administrativeArea ?? ""
		let zip = placemark.postalCode ?? ""
		
		return "\(address)\n \(locality), \(adminArea)\n, \(zip)"
	}
	
	func setRegion() -> MKCoordinateRegion? {
		guard let placemark = placemark else { return nil }
		
		guard let location = placemark.location else { return nil }
		
		let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
		let span = MKCoordinateSpanMake(0.2, 0.2)
		
		return MKCoordinateRegionMake(center, span)
	}
}
