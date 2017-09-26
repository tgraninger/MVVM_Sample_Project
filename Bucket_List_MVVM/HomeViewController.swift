//
//  HomeViewController.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 9/14/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	
	@IBOutlet weak var bucketImageView: UIImageView!
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var addButton: UIButton!
	
	@IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
	
	var viewModel: HomeViewModel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		viewModel = viewModel ?? HomeViewModel()
		
		viewModel.delegate = viewModel.delegate ?? self
		
		viewModel.fetchBuckets()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
	
	}

	@IBAction func addButtonPressed(_ sender: Any) {
		
	}
	
	func filterChanged() {
		// Change button name
	}
	
	func tiltBucket() {
		UIView.animate(withDuration: 2.0, animations: {
			self.bucketImageView.transform = CGAffineTransform(rotationAngle: 1.8)

			self.view.layoutIfNeeded()
		})
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			self.dumpItemFromBucketAnimation(0)
		}
	}
	
	func dumpItemFromBucketAnimation(_ animationCount: Int) {
		let label = UILabel(frame: CGRect(x: bucketImageView.frame.width + 20, y: bucketImageView.center.y, width: view.bounds.width, height: 50))
		label.text = viewModel.buckets[animationCount].name
		label.textColor = UIColor.white
		label.adjustsFontSizeToFitWidth = true
		label.font = label.font.withSize(24.0)
		
		self.view.addSubview(label)
		
		let newCount = animationCount + 1
		
		self.performAnimations("SPILLING_BUCKET", object: label, duration: 1.5) {
			label.removeFromSuperview()
			
			if newCount == self.viewModel.buckets.count {
				self.showList()
			}
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			if newCount < self.viewModel.buckets.count {
				self.dumpItemFromBucketAnimation(newCount)
			}
		}
	}
	
	func showList() {
		addButton.isHidden = false
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: "ListItemsViewController") as! BucketItemsViewController
		
		viewController.viewModel = BucketItemsViewModel()
		
		switch viewModel.filter {
		case .Items:
			viewController.viewModel.dataStore = viewModel.items
			break
		default:
			break
		}
		
		self.addChildViewController(viewController)
		viewController.view.frame = containerView.bounds
		self.containerView.addSubview(viewController.view)
		viewController.didMove(toParentViewController: self)
				
		performAnimations("SHOWING_ITEMS", object: nil, duration: 0.5) {}
	}

	func performAnimations(_ type: String, object: UILabel?, duration: TimeInterval, completion: @escaping ()->()) {
		UIView.animate(withDuration: duration, animations: {
			if type == "SPILLING_BUCKET" {
				object!.frame = CGRect(x: object!.frame.origin.x, y: self.view.bounds.height + 100, width: 100, height: 21)
				object!.transform = CGAffineTransform(rotationAngle: 9.0)
			} else if type == "SHOWING_ITEMS" {
				self.containerViewHeightConstraint.constant = self.view.bounds.height - 44
				
				self.bucketImageView.removeFromSuperview()
			}
			
			self.view.layoutIfNeeded()
		}) { (_) in
			completion()
		}
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

extension HomeViewController: HomeViewModelDelegate {

	func setItems() {
		self.tiltBucket()
	}
	
	func updateDataStore() {
		
	}
}



