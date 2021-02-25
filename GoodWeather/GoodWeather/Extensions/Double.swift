//
//  Double.swift
//  GoodWeather
//
//  Created by Myron Dulay on 2/22/21.
//

import Foundation

extension Double {
	
	var formatAsDegree: String {
		return String(format: "%.0f°", self)
	}
	
	var inFarenheit: Double {
		return (self * 9/5) + 32
	}
	
	var inCelsius: Double {
		return (self - 32) * 5/9
	}
}
