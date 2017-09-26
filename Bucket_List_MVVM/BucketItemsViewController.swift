//
//  BucketItemsViewController.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit

class BucketItemsViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	
	var viewModel: BucketItemsViewModel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		viewModel.delegate = self

		self.edgesForExtendedLayout = []
		self.automaticallyAdjustsScrollViewInsets = false
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		viewModel.setItems()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "pushAddItemViewController" {
			let viewController = segue.destination as! AddBucketListItemViewController
			
			viewController.viewModel = AddBucketItemViewModel()
			
		} else if segue.identifier == "showMapViewController" {
			let viewController = segue.destination as! MapViewController
			
			viewController.viewModel = MapViewModel()
			
			let selectedIndex: IndexPath! = collectionView.indexPathsForSelectedItems![0]
			
			viewController.viewModel.item = viewModel.dataStore![selectedIndex.row]
			viewController.viewModel.settingLocation = false
		}
    }
}

// MARK: - Collection View Data Source

extension BucketItemsViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.dataStore?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BUCKET_ITEM_CELL", for: indexPath) as! BucketItemCollectionViewCell
		
		let item = viewModel.dataStore![indexPath.row]
		
		cell.setCellData(item)
		
		return cell
	}
}

// MARK: - Collection View Delegate

extension BucketItemsViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "showMapViewController", sender: self)
	}
}

extension BucketItemsViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: collectionView.bounds.width - 20, height: (collectionView.bounds.height - 50) / 4)
	}
}

// MARK: - View Model Delegate

extension BucketItemsViewController: BucketItemsViewModelDelegate {
	
	func reloadData() {
		collectionView.reloadData()
	}
}

