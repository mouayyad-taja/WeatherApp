//
//  WeatherDataSource.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation
import UIKit

class WeatherDataSource: GenericDataSource<WeatherForecast>, UITableViewDelegate, UITableViewDataSource {
    
    //closure selecting item
    var onSelectItem: CompletionHandler<WeatherForecast>?
    
    //MARK: Initialization
    init(onSelectItem: CompletionHandler<WeatherForecast>?) {
        super.init()
        self.onSelectItem = onSelectItem
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: WeatherForecastDayTVC.self, for: indexPath)
        let item = self.data.value[indexPath.row]
        cell.configCellUI()
        cell.item = item
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

