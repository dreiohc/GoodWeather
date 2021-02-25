//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by Myron Dulay on 2/17/21.
//

import UIKit

protocol AddWeatherCityDelegate: class {
	func addWeatherCityViewControllerDidSave(weather: WeatherViewModel, controller: UIViewController)
}

class AddWeatherCityViewController: UIViewController, Alertable {
	
	weak var delegate: AddWeatherCityDelegate?
	
	@IBOutlet weak var cityNameTextField: UITextField!
	
	@IBAction func saveCityButtonTapped() {
		if let city = cityNameTextField.text {
			
			let userdefaults = UserDefaults.standard
			let units = userdefaults.value(forKey: "unit")
			
			guard let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Constant.openWeatherAPIKey)&units=\(units!)") else {
				self.showAlert(title: "Invalifd URL", message: nil)
				return
			}
			
			let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
				
				do {
					let weatherVM = try JSONDecoder().decode(WeatherViewModel.self, from: data)
					return weatherVM
				} catch (let error) {
					self.showAlert(title: "We couldn't find \(city.uppercased()) city.", message: error.localizedDescription)
					return nil
				}
			}
			WebService().load(resource: weatherResource) { [weak self] result in
				
				switch result {
				case .success(let weatherVM):
					
					guard let weatherVM = weatherVM else {
						return
					}
					
					if let delegate = self?.delegate {
						DispatchQueue.main.async {
							delegate.addWeatherCityViewControllerDidSave(weather: weatherVM, controller: self!)
							self?.dismiss(animated: true, completion: nil)
						}
					}
				case .failure(let error):
					self?.showAlert(title: "We couldn't find \(city.uppercased()) city.", message: error.localizedDescription)
				}
			}
		}
	}
	
	@IBAction func closeButtonTapped() {
		self.dismiss(animated: true, completion: nil)
	}
	
}
