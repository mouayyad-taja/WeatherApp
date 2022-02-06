//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation

class WeatherDetailsViewModel {
        
    //Weather info dataSource
    private(set) weak var dataSource : GenericDataSource<WeatherInfo>?
    
    //Observable data
    private(set) var data : DynamicValue<(WeatherMainInfo,[WeatherInfo])?> = DynamicValue<(WeatherMainInfo,[WeatherInfo])?>(nil)

    private(set) var weatherDayForecast : WeatherForecast?
    private(set) var weatherCollection : WeatherForecastCollection?

    //Observable error
    private(set) var error : DynamicValue<Error?> = DynamicValue<Error?>(nil)
    
    //MARK: Initialization
    init(dataSource : GenericDataSource<WeatherInfo>?, weatherCollection: WeatherForecastCollection ,weatherDayForecast: WeatherForecast) {
        self.dataSource = dataSource
        self.weatherDayForecast = weatherDayForecast
        self.weatherCollection = weatherCollection
        self.getWeatherDetailsList()
    }

    //Get weather details
    func getWeatherDetailsList(){
        guard let weatherDayForecast = weatherDayForecast, let weatherCollection = weatherCollection else {
            return
        }

        let weatherMainInfo = WeatherMainInfo(dateTime: weatherDayForecast.datetime, cityName: weatherCollection.cityName, temp: weatherDayForecast.temp, lowTemp: weatherDayForecast.lowTemp, highTemp: weatherDayForecast.highTemp, weather: weatherDayForecast.weather)
        
        let listInfo :[WeatherInfo] = weatherDayForecast.getWeatherInfo()
        self.data.value = (weatherMainInfo, listInfo)
        self.dataSource?.data.value = listInfo
    }
    
}


