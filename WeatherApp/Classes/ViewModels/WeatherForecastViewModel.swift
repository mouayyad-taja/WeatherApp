//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation

class WeatherForecastViewModel {
    
    //Api reference
    private var apiService : WeatherRepositoryProtocol?
    
    //Weather dataSource
    private(set) weak var dataSource : GenericDataSource<WeatherForecast>?
    
    //Observable data
    private(set) var data : DynamicValue<WeatherForecastCollection?> = DynamicValue<WeatherForecastCollection?>(nil)

    //Observable error
    private(set) var error : DynamicValue<Error?> = DynamicValue<Error?>(nil)
    
    //MARK: Initialization
    init(dataSource : GenericDataSource<WeatherForecast>?, apiService: WeatherRepositoryProtocol? = WeatherRepository()) {
        self.dataSource = dataSource
        self.apiService = apiService
        
        NotificationCenter.default.addObserver(self, selector: #selector(onUpdateUnit(_:)), name: .didUpdateUnit, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //Get list weather forecasst
    func getWeatherForecastList(){
        self.apiService?.fetchWeatherForecast{
            result in
            switch result {
            case .success(let item):
                self.handleWeatherForecastListResponse(weatherCollection: item)
            case .failure(let error):
                print("error \(error)")
                self.error.value = error
            }
        }
    }
    
    func handleWeatherForecastListResponse(weatherCollection: WeatherForecastCollection){
        //update list datasource items
        let items = weatherCollection.data ?? []
        self.dataSource?.data.value = items
        
        self.data.value = weatherCollection
        
        //schedule notifications
        LocalNotificationManager.shared.scheduleNotifications(weatherList: items)
    }
    
    //Hanlde updated unit
    @objc func onUpdateUnit(_ notification:Notification){
        if (notification.object as? UnitKey) != nil, self.data.value != nil {
            self.dataSource?.data.forceNotify()
            self.data.forceNotify()
        }
    }
}


