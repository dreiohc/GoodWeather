//
//  WeatherCell.swift
//  GoodWeather
//
//  Created by Myron Dulay on 2/17/21.
//

import UIKit

class WeatherCell: UITableViewCell {
	
	@IBOutlet weak var cityNameLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var tempHighAndLowLabel: UILabel!
	
	func configure(_ vm: WeatherViewModel) {
		self.cityNameLabel.text = "\(vm.name)"
		self.temperatureLabel.text = "\(vm.currentTemperature.temperature.formatAsDegree)"
		self.tempHighAndLowLabel.text = "High: \(vm.currentTemperature.temperatureMax.formatAsDegree)\nlow: \(vm.currentTemperature.temperatureMin.formatAsDegree)"
	}
}
