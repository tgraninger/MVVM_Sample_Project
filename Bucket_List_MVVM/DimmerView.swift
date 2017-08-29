//
//  DimmerView.swift
//  Bucket_List_MVVM
//
//  Created by Thomas on 8/28/17.
//  Copyright © 2017 MajorTom. All rights reserved.
//

import UIKit

class DimmerView: UIView {
	
	var dimmerView: UIView?
	var activityIndicator: UIActivityIndicatorView?
	var successBox: UIView?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		dimmerView = UIView(frame: self.bounds)
		dimmerView?.backgroundColor = UIColor.black
		dimmerView?.alpha = 0.2
		
		activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: self.center, size: CGSize(width: 50, height: 50)))
		activityIndicator?.activityIndicatorViewStyle = .whiteLarge
		
		activityIndicator?.startAnimating()
		
		self.addSubview(dimmerView!)
		self.addSubview(activityIndicator!)
	}
	
	func animateSuccess() {
		activityIndicator?.isHidden = true
		activityIndicator?.stopAnimating()
		
		successBox = UIView(frame: CGRect(origin: self.center, size: CGSize(width: 50, height: 50)))
		
		self.dimmerView!.addSubview(successBox!)
		
		UIView.animate(withDuration: 2.0, animations: {
			let path = UIBezierPath()
			path.move(to: CGPoint(x: (self.successBox?.frame.origin.x)! + 10, y: (self.successBox?.frame.origin.y)! + 25))
			path.addLine(to: CGPoint(x: (self.successBox?.frame.origin.x)! + 25, y: (self.successBox?.frame.origin.y)! + 45))
			path.addLine(to: CGPoint(x: (self.successBox?.frame.origin.x)! + 45, y: (self.successBox?.frame.origin.y)! + 5))
			
			let shapeLayer = CAShapeLayer()
			shapeLayer.path = path.cgPath
			shapeLayer.strokeColor = UIColor.white.cgColor
			shapeLayer.lineWidth = 2.0
			
			self.successBox?.layer.addSublayer(shapeLayer)
		}) { (_) in
			
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	/*
	// Only override draw() if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func draw(_ rect: CGRect) {
	// Drawing code
	}
	*/
}
