//
//  AddCategoryViewController.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {

	// Outlets
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var backgroundImageView: UIImageView!
	
	// Vars
	var viewModel: AddCategoryViewModel!
	var dimmerView: DimmerView?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = AddCategoryViewModel()
    }
	
	@IBAction func saveButtonPressed(_ sender: UIButton) {
		//dimmerView = DimmerView(frame: self.view.bounds)
		
		//self.view.addSubview(dimmerView!)
		
		viewModel.delegate = self
		
		viewModel.addCategory(nameField.text)
	}
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddCategoryViewController: AddCategoryViewModelDelegate {
	
	func successfullyStoredObject() {
		//dimmerView?.animateSuccess()
		
		self.navigationController?.popViewController(animated: true)
	}
	
	func failedToStoreObject() {
		
	}
	
	func presentAlertForEmptyFields() {
		let alert = UIAlertController(title: "Empty fields", message: "Please name the category.", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		
		alert.addAction(action)
		
		self.present(alert, animated: true, completion: nil)
	}
}
