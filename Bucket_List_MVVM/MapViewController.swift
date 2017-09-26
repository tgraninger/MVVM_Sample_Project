//
//  MapViewController.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/30/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIGestureRecognizerDelegate {

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
	var imagesViewModel: AddImageViewModel?
	var infoBarIsLarge: Bool! = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		viewModel.delegate = self
		
		viewModel.fetchLocation()
		
		setupView()
    }
	
	func setupView() {
		nameLabel.text = viewModel.item!.name
		dateLabel.text = NSDate().formatDate(viewModel.item!.dateAdded!)
		
		imagesCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IMAGE_CELL")
	}
	
	@IBAction func infoBarTapped(_ sender: UITapGestureRecognizer) {
		resizeInfoBar()
	}
	
	@IBAction func infoBarSwiped(_ sender: UISwipeGestureRecognizer) {
		if sender.direction == .up || sender.direction == .down {
			resizeInfoBar()
		}
	}
	
	func resizeInfoBar() {
		if infoBarIsLarge {
			infoBarHeightConstraint.constant = 55
			
			collectionViewHeightConstraint.constant = 0
			
			imagesViewModel = nil
		} else {
			infoBarHeightConstraint.constant = 175
			
			collectionViewHeightConstraint.constant = 120
			
			imagesViewModel = AddImageViewModel()
			
			imagesViewModel!.delegate = self
			
			imagesViewModel!.fetchImages(viewModel.item!.name)
		}

		infoBarIsLarge = !infoBarIsLarge
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MapViewController: UISearchBarDelegate {

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.view.endEditing(true)
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.view.endEditing(true)
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		viewModel.searchLocation(searchBar.text)
	}
}

extension MapViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let viewModel = imagesViewModel else { return 0 }
		
		return viewModel.dataStore?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IMAGE_CELL", for: indexPath) as! ImageCollectionViewCell
		
		let urlString = imagesViewModel!.dataStore![indexPath.row]
		
		cell.setImage(urlString)
		
		return cell
	}
}

extension MapViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 100, height: 100)
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
	
	func updateLocationSearchResults(_ mapItems: [MKMapItem]) {
		for item in mapItems {
			mapView.addAnnotation(item.placemark)
		}
	}
}

extension MapViewController: AddImageViewModelDelegate {
	
	func reloadData() {
		imagesCollectionView.reloadData()
	}
}
