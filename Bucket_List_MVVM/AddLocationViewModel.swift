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
//	func updateSearchResults()
}

class MapViewModel {
	
	weak var delegate: MapViewModelDelegate!
	var settingLocation: Bool!
	var item: BLItemMO?
	var itemLocation: BLItemLocation?
	var searchResults: [MKMapItem]?
	
	func fetchLocation() {
		let client = LocationServicesClient()
		
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
		
		delegate.setPlacemark(placemark)
		delegate.setAddress(itemLocation!.setAddress())
		delegate.setRegion(itemLocation!.setRegion()!)
	}
	
	func locationSearchResults(_ locations: [MKMapItem]) {
		searchResults = locations
	}
}
