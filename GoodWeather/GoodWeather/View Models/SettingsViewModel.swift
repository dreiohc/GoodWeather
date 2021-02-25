//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by Myron Dulay on 2/22/21.
//

import Foundation

enum Unit: String, CaseIterable {
	
	case celsius = "metric"
	case fahrenheit = "imperial"
	
}

extension Unit {
	
	var displayName: String {
		get {
			switch(self) {
			case .celsius:
				return "Celsius"
			case .fahrenheit:
				return "Fahrenheit"
			}
		}
	}
}

struct SettingsViewModel {
	
	let units = Unit.allCases
	let userDefaults = UserDefaults.standard
	private var _selectedUnit: Unit = Unit.celsius
	
	var selectedUnit: Unit {
		get {
			if let value = userDefaults.value(forKey: "unit") as? String {
				return Unit(rawValue: value)!
			}
			return _selectedUnit
			
		} set {
			userDefaults.set(newValue.rawValue, forKey: "unit")
		}
	}
	

}
