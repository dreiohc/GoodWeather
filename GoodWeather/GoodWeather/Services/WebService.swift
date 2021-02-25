//
//  WebService.swift
//  GoodWeather
//
//  Created by Myron Dulay on 2/18/21.
//

import Foundation

struct Resource<T> {
	let url: URL
	let parse: (Data) -> T?
}

final class WebService {
	
	func load<T>(resource: Resource<T>, completion: @escaping (Result<T?, Error>) -> ()) {
		
		URLSession.shared.dataTask(with: resource.url) { data, response, error in
			
			if let data = data, error == nil {
				DispatchQueue.main.async {
					completion(.success(resource.parse(data)))
				}
			} else {
				completion(.failure(error!))
				return
			}
			
		}.resume()
	}
	
	
	
}
