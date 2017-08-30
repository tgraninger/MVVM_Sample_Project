//
//  AddBucketListItemViewController.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit

protocol AddBucketListItemViewControllerDelegate: class {
	func shareUpdates(_ hasItems: Bool)
}

class AddBucketListItemViewController: UIViewController {
	
	@IBOutlet var buttons: [UIButton]!
	@IBOutlet weak var itemNameField: UITextField!
	
	weak var delegate: AddBucketListItemViewControllerDelegate!
	var viewModel: AddBucketItemViewModel!

	// MARK: - Life Cycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		viewModel.delegate = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		itemNameField.text = viewModel.setNameFieldText()		
	}
	
	// MARK: - Actions
	
	@IBAction func addImageButtonTapped(_ sender: UIButton) {
		
	}
	
	@IBAction func addLocationButtonTapped(_ sender: UIButton) {
		
	}
	
	@IBAction func saveButtonTapped(_ sender: UIButton) {
		viewModel.saveItem()
		
		delegate.shareUpdates(true)
		
		self.navigationController?.popViewController(animated: true)
	}
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showImagesViewController" {
			let viewController = segue.destination as! AddImageViewController
			
			viewController.delegate = self
			
			viewController.viewModel = AddImageViewModel()
			
			viewController.viewModel.newItem = viewModel.newItem
		} else if segue.identifier == "" {
			let viewController = segue.destination as! MapViewController
			
			viewController.viewModel = MapViewModel()
			
			viewController.viewModel.settingLocation = true
		}
    }
}

// MARK: - Text Field Delegate

extension AddBucketListItemViewController: UITextFieldDelegate {
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if let text = textField.text as? NSString {
			let updatedText = text.replacingCharacters(in: range, with: string)
			viewModel.setName(updatedText)
		}
		
		return true
	}
}

// MARK: - View Model Delegate

extension AddBucketListItemViewController: AddBucketItemViewModelDelegate {
	
	func nameValidated(_ success: Bool) {
		for button in buttons {
			button.isEnabled = success
		}
	}
}

extension AddBucketListItemViewController: AddImageViewControllerDelegate {
	
	func shareItem(_ item: BLItemMO) {
		viewModel.newItem = item
	}
}
