//
//  SettingsDataSource.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation
import UIKit

class SettingsDataSource: GenericDataSource<UnitKey>, UITableViewDelegate, UITableViewDataSource {
    
    //closure selecting item
    var onSelectItem: CompletionHandler<UnitKey>?
    var settings: SettingsProtocol?
    
    //MARK: Initialization
    init(onSelectItem: CompletionHandler<UnitKey>?, settings: SettingsProtocol?) {
        super.init()
        self.onSelectItem = onSelectItem
        self.settings = settings
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SettingsTVC.self, for: indexPath)
        let item = self.data.value[indexPath.row]
        cell.item = item
        cell.isSelectedItem = self.settings?.isSelectedUnit(unit: item) ?? false
        cell.configCellUI()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            let item = self.data.value[indexPath.row]
        self.onSelectItem?(item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


