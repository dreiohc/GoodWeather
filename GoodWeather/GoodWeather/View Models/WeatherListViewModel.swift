//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by Myron Dulay on 2/19/21.
//

import Foundation

struct WeatherListViewModel {
	
	private var weatherViewModel = [WeatherViewModel]()
	
	mutating func addWeatherViewModel(_ vm: WeatherViewModel) {
		self.weatherViewModel.append(vm)
	}
	
	func numberOfRows(_ section: Int) -> Int {
		return self.weatherViewModel.count
	}
	
	func modelAt(_ index: Int) -> WeatherViewModel {
		return self.weatherViewModel[index]
	}
	
	mutating func updateUnit(to unit: Unit) {
		switch unit {
		case .celsius:
			toCelsius()
		case .fahrenheit:
			toFarenheit()
		}
	}
	
	mutating private func toCelsius() {
		
		weatherViewModel = weatherViewModel.map { vm in
			var weatherModel = vm
			weatherModel.currentTemperature.temperature = weatherModel.currentTemperature.temperature.inCelsius
			weatherModel.currentTemperature.temperatureMin = weatherModel.currentTemperature.temperatureMin.inCelsius
			weatherModel.currentTemperature.temperatureMax = weatherModel.currentTemperature.temperatureMax.inCelsius
			return weatherModel
		}
	}
	
	mutating private func toFarenheit() {
		
		weatherViewModel = weatherViewModel.map { vm in
			var weatherModel = vm
			weatherModel.currentTemperature.temperature = weatherModel.currentTemperature.temperature.inFarenheit
			weatherModel.currentTemperature.temperatureMin = weatherModel.currentTemperature.temperatureMin.inFarenheit
			weatherModel.currentTemperature.temperatureMax = weatherModel.currentTemperature.temperatureMax.inFarenheit
			return weatherModel
		}
	}
}

struct WeatherViewModel: Decodable {
	var currentTemperature: TemperatureViewModel
	let name: String

	private enum CodingKeys: String, CodingKey {
		case currentTemperature = "main"
		case name
	}
}

struct TemperatureViewModel: Decodable  {
	var temperature: Double
	var temperatureMin: Double
	var temperatureMax: Double
	
	private enum CodingKeys: String, CodingKey {
		case temperature = "temp"
		case temperatureMin = "temp_min"
		case temperatureMax = "temp_max"
	}
}


