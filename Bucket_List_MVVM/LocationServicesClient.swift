//
//  LocationServicesClient.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/30/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation
import MapKit

protocol LocationServicesClientDelegate: class {
	func setLocation(_ location: BLItemLocation)
	func updateLocationSearchResults(_ locations: [MKMapItem]?)
}

class LocationServicesClient: NSObject, CLLocationManagerDelegate {
	
	static let sharedInstance = LocationServicesClient()
	
	var location: CLLocation?
	weak var delegate: LocationServicesClientDelegate!
	var locationManager: CLLocationManager!
	
	override init() {
		super.init()
		
		self.locationManager = CLLocationManager()
		
		guard let locationManager = self.locationManager else { return }
		
		switch CLLocationManager.authorizationStatus() {
		case .notDetermined, .restricted, .denied:
			locationManager.requestWhenInUseAuthorization()
			break
		default:
			break
		}
		
		locationManager.delegate = self
	}
	
	func fetchLocation(_ location: BLItemLocationMO?) {
		if location != nil {
			geocodeLocation(["latitude" : location!.latitude, "longitude" : location!.longitude])
		} else {
			self.locationManager.startUpdatingLocation()
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
				self.locationManager.requestWhenInUseAuthorization()
				break
			default:
				break
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		
		self.locationManager.stopUpdatingLocation()
		
		let lat = location.coordinate.latitude
		let ln = location.coordinate.longitude
			
		geocodeLocation(["latitude" : lat, "longitude" : ln])
	}
	
	func searchLocation(text: String) {
		
		let request = MKLocalSearchRequest()
		request.naturalLanguageQuery = text
		
//		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//		request.region = MKCoordinateRegionMake(self.location!.coordinate, span)
		
		var responseItems = [MKMapItem]()
		
		let search = MKLocalSearch(request: request)
		search.start { (response, error) in
			for mapItem in (response?.mapItems)! as [MKMapItem] {
				responseItems.append(mapItem)
			}
			self.delegate.updateLocationSearchResults(responseItems)
		}
	}
}
