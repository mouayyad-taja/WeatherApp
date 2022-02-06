//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation

class WeatherForecastViewModel {
    
    //Api reference
    private var apiService : WeatherRepository?
    
    //Weather dataSource
    private(set) weak var dataSource : GenericDataSource<WeatherForecast>?
    
    //Observable data
    private(set) var data : DynamicValue<WeatherForecastCollection?> = DynamicValue<WeatherForecastCollection?>(nil)

    //Observable error
    private(set) var error : DynamicValue<Error?> = DynamicValue<Error?>(nil)
    
    //MARK: Initialization
    init(dataSource : GenericDataSource<WeatherForecast>?, apiService: WeatherRepository? = WeatherRemoteRepository()) {
        self.dataSource = dataSource
        self.apiService = apiService
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
    }
}


