//
//  UIAlert.swift
//  GoodWeather
//
//  Created by Myron Dulay on 2/19/21.
//

import UIKit

protocol Alertable { }
extension Alertable where Self: UIViewController {
	
	func showAlert(title: String, message: String?) {
		
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
		alertController.addAction(okAction)
		
		DispatchQueue.main.async {
			self.present(alertController, animated: true, completion: nil)
		}
	}
}
