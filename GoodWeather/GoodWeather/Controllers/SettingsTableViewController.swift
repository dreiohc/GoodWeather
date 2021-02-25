//
//  SettingsTableViewController.swift
//  GoodWeather
//
//  Created by Myron Dulay on 2/22/21.
//


import UIKit

protocol SettingsDelegate: class {
	func settingsDone(vm: SettingsViewModel)
}

class SettingsTableViewController: UITableViewController {
	
	weak var delegate: SettingsDelegate?
	private var settingsVM = SettingsViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	@IBAction func doneButtonTapped() {
		if let delegate = self.delegate {
			delegate.settingsDone(vm: settingsVM)
		}
		self.dismiss(animated: true, completion: nil)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.settingsVM.units.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let settingItem = self.settingsVM.units[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
		cell.textLabel?.text = settingItem.displayName
		
		if settingItem == self.settingsVM.selectedUnit {
			cell.accessoryType = .checkmark
		}
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// uncheck all cells
		tableView.visibleCells.forEach { cell in
			cell.accessoryType = .none
		}
		
		if let cell = tableView.cellForRow(at: indexPath) {
			cell.accessoryType = .checkmark
			let unit = Unit.allCases[indexPath.row]
			self.settingsVM.selectedUnit = unit
		}
	}
	
	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			cell.accessoryType = .none
		}
	}
	
}
