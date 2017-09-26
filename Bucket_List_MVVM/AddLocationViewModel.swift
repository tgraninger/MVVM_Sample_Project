//
//  AddLocationViewModel.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import Foundation
import MapKit

protocol MapViewModelDelegate: class {
	func setPlacemark(_ placemark: MKPlacemark)
	func setRegion(_ region: MKCoordinateRegion)
	func setAddress(_ address: String)
	func updateLocationSearchResults(_ mapItems: [MKMapItem])
}

class MapViewModel {
	
	weak var delegate: MapViewModelDelegate!
	var settingLocation: Bool!
	var item: BLItemMO?
	var itemLocation: BLItemLocation?
	
	func fetchLocation() {
		
		let client = LocationServicesClient.sharedInstance
		
		client.delegate = self
		
		let location = item != nil ? item!.location : nil
		
		client.fetchLocation(location)
	}
	
	func searchLocation(_ searchText: String?) {
		guard let searchText = searchText else { return }
		
		let client = LocationServicesClient()
		
		client.delegate = self
		
		client.searchLocation(text: searchText)
	}
}

extension MapViewModel: LocationServicesClientDelegate {
	
	func setLocation(_ location: BLItemLocation) {
		itemLocation = location
		
		let placemark = MKPlacemark(placemark: location.placemark)
		let address = itemLocation!.setAddress()
		let region = itemLocation!.setRegion()!
		
		self.delegate.setAddress(address)
		self.delegate.setPlacemark(placemark)
		self.delegate.setRegion(region)
	}
	
	func updateLocationSearchResults(_ locations: [MKMapItem]?) {
		guard let locations = locations else { return }
		
		let coordinate = locations.first?.placemark.coordinate
		let span = MKCoordinateSpanMake(1.0, 1.0)
		
		self.delegate.setRegion(MKCoordinateRegionMake(coordinate!, span))
		
		delegate.updateLocationSearchResults(locations)
	}
}
