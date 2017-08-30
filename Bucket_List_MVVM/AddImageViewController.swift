//
//  AddImageViewController.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit
import AVFoundation

protocol AddImageViewControllerDelegate: class {
	func shareItem(_ item: BLItemMO)
}

class AddImageViewController: UIViewController {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var collectionView: UICollectionView!
	
	var viewModel: AddImageViewModel!
	weak var delegate: AddImageViewControllerDelegate!
	
	// MARK: - Life Cycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		viewModel.delegate = self
		
		viewModel.fetchImages(viewModel.newItem.name)
		
		self.edgesForExtendedLayout = []
		self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - View Model Delegate

extension AddImageViewController: AddImageViewModelDelegate {
	
	func reloadData() {
		collectionView.reloadData()
	}
	
	func dismissViewController() {
		delegate.shareItem(viewModel.newItem)
		
		self.navigationController?.popViewController(animated: true)
	}
}

// MARK: - Collection View Data Source

extension AddImageViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		viewModel.setImage(indexPath.row)
	}
}

// MARK: - Collection View Delegate

extension AddImageViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.dataStore?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IMAGE_CELL", for: indexPath) as! ImageCollectionViewCell
		
		let url = viewModel.dataStore![indexPath.row]
		
		cell.setImage(url)
		
		return cell
	}
}

// MARK: - Collection View Delegate Flow Layout

extension AddImageViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: (collectionView.bounds.width - 10) / 2, height: (collectionView.bounds.width - 10) / 2)
	}
}

extension AddImageViewController: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		viewModel.fetchImages(searchText)
	}
}


