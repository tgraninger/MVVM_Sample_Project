//
//  MapViewController.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/30/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

	// Outlets
	@IBOutlet weak var infoBarView: UIView!
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var imagesHeaderLabel: UILabel!
	@IBOutlet weak var imagesCollectionView: UICollectionView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	// Constraints
	@IBOutlet weak var infoBarHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
	
	// Vars
	var viewModel: MapViewModel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		viewModel.fetchLocation()
		
		if viewModel.settingLocation == false {
			nameLabel.text = viewModel.item!.name
			dateLabel.text = NSDate().formatDate(viewModel.item!.dateAdded!)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MapViewController: MapViewModelDelegate {
	
	func setAddress(_ address: String) {
		addressLabel.text = address
	}
	
	func setRegion(_ region: MKCoordinateRegion) {
		mapView.setRegion(region, animated: true)
	}
	
	func setPlacemark(_ placemark: MKPlacemark) {
		mapView.addAnnotation(placemark)
	}
}
