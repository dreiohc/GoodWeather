//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by Myron Dulay on 2/17/21.
//

import UIKit

class WeatherListTableViewController: UITableViewController, Alertable {
	
	private var weatherListVM = WeatherListViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	private func addWeatherDidSave(vm: WeatherViewModel) {
		self.weatherListVM.addWeatherViewModel(vm)
		self.tableView.reloadData()
	}
	
	private func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
		
		guard let nav = segue.destination as? UINavigationController,
			  let addWeatherCityVC = nav.viewControllers.first as? AddWeatherCityViewController else {
			showAlert(title: "Failed to open add", message: nil)
			return
		}
		addWeatherCityVC.delegate = self
	}
	
	private func prepareSegueForSettingsTableViewController(segue: UIStoryboardSegue) {
		
		guard let nav = segue.destination as? UINavigationController, let settingsTVC = nav.viewControllers.first as? SettingsTableViewController else {
			showAlert(title: "Failed to open Settings", message: nil)
			return
		}
		settingsTVC.delegate = self
	}

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "showAddCity" {
			self.prepareSegueForAddWeatherCityViewController(segue: segue)
		} else if segue.identifier == "showSettings" {
			self.prepareSegueForSettingsTableViewController(segue: segue)
		}
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.weatherListVM.numberOfRows(section)
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
			fatalError("Error calling cell")
		}
		
		let weatherVM = self.weatherListVM.modelAt(indexPath.row)
		cell.configure(weatherVM)
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
}

extension WeatherListTableViewController: AddWeatherCityDelegate {
	
	func addWeatherCityViewControllerDidSave(weather: WeatherViewModel, controller: UIViewController) {
		
		controller.dismiss(animated: true, completion: nil)
		self.weatherListVM.addWeatherViewModel(weather)
		self.tableView.insertRows(at: [IndexPath.init(row: self.weatherListVM.numberOfRows(0) - 1, section: 0)], with: .automatic)
	}
}

extension WeatherListTableViewController: SettingsDelegate {
	func settingsDone(vm: SettingsViewModel) {
		self.weatherListVM.updateUnit(to: vm.selectedUnit)
		self.tableView.reloadData()
	}
	
	
}
