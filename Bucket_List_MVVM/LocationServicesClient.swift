//
//  LocationServicesClient.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/30/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol LocationServicesClientDelegate: class {
	func setLocation(_ location: BLItemLocation)
	func locationSearchResults(_ locations: [MKMapItem])
}

class LocationServicesClient: NSObject, CLLocationManagerDelegate {
	
	private let locationManager = CLLocationManager()
	var location: CLLocation?
	weak var delegate: LocationServicesClientDelegate!
	
	func fetchLocation(_ location: BLItemLocationMO?) {
		
		locationManager.delegate = self
		
		switch CLLocationManager.authorizationStatus() {
		case .notDetermined, .restricted, .denied:
			locationManager.requestWhenInUseAuthorization()
			break
		default:
			if location != nil {
				geocodeLocation(["latitude" : location!.latitude, "longitude" : location!.longitude])
			} else {
				locationManager.startUpdatingLocation()
			}
			break
		}
	}
	
	func geocodeLocation(_ location: [String : Any]) {
		let lat = location["latitude"] as! CLLocationDegrees
		let ln = location["longitude"] as! CLLocationDegrees
		
		let location = CLLocation(latitude: lat, longitude: ln)
		
		CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
			if error != nil {
				self.locationManager.startUpdatingLocation()
				return
			}
			
			guard let placemarks = placemarks else {
				return
			}
			
			if placemarks.count > 0 {
				let itemLocation = BLItemLocation(placemarks[0])
				
				self.delegate.setLocation(itemLocation)
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if CLLocationManager.locationServicesEnabled() {
			switch CLLocationManager.authorizationStatus() {
			case .notDetermined, .restricted, .denied:
				locationManager.requestWhenInUseAuthorization()
			default:
				break
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if locations.first != nil {
			locationManager.stopUpdatingLocation()
			
			let l = locations.first!
			
			let lat = l.coordinate.latitude
			let ln = l.coordinate.longitude
			
			geocodeLocation(["latitude" : lat, "longitude" : ln])
		}
	}
	
	func searchLocation(text: String) {
		
		let request = MKLocalSearchRequest()
		request.naturalLanguageQuery = text
		
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
		request.region = MKCoordinateRegionMake(self.location!.coordinate, span)
		
		var responseItems: [MKMapItem]!
		
		let search = MKLocalSearch(request: request)
		search.start { (response, error) in
			for mapItem in (response?.mapItems)! as [MKMapItem] {
				print("Item name: \(mapItem.name)")
				responseItems.append(mapItem)
			}
			self.delegate.locationSearchResults(responseItems)
		}
	}
}
