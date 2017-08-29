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
	
	@IBOutlet weak var headerLabelHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var headerLabelTopLayoutVerticalSpacing: NSLayoutConstraint!
	
	var viewModel: BucketItemsViewModel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		viewModel.delegate = self
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
			
			viewController.viewModel.selectedCategory = viewModel.selectedCategory
		}
    }
}

extension BucketItemsViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.dataStore?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BUCKET_ITEM_CELL", for: indexPath) as! BucketItemCollectionViewCell
		
		let item = viewModel.dataStore![indexPath.row]
		
		cell.setCellData(item.imageString, itemName: item.name!)
		
		return cell
	}
}

extension BucketItemsViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
}

extension BucketItemsViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let length = collectionView.bounds.width / 2
		
		return CGSize(width: length, height: length)
	}
}

extension BucketItemsViewController: BucketItemsViewModelDelegate {
	
	func reloadData() {
		collectionView.reloadData()
		
		if viewModel.hasItems == false {
			headerLabelHeightConstraint.constant = 44
			headerLabelTopLayoutVerticalSpacing.constant = 12
			
			UIView.animate(withDuration: 0.5, animations: { 
				self.view.setNeedsLayout()
			})
		}
	}
}

