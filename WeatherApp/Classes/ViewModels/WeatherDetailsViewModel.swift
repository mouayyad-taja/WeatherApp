//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation

class WeatherDetailsViewModel {
        
    //stories dataSource
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
    
    //Get list weather forecasst
    func getWeatherDetailsList(){
        guard let weatherDayForecast = weatherDayForecast, let weatherCollection = weatherCollection else {
            return
        }

        let weatherMainInfo = WeatherMainInfo(dateTime: weatherDayForecast.datetime, cityName: weatherCollection.cityName, temp: weatherDayForecast.temp, lowTemp: weatherDayForecast.lowTemp, highTemp: weatherDayForecast.highTemp, weather: weatherDayForecast.weather)
        
        var listInfo :[WeatherInfo] = [
            WeatherInfo(title: "Wind speed", icon: "wind", value: UnitManager.shared.formatValueUnit(weatherDayForecast.windSpd, unit: .WindSpeed)),
            WeatherInfo(title: "Wind direction", icon: "wind", value: weatherDayForecast.windCdirFull),
            WeatherInfo(title: "Sunrise", icon: "wind", value: weatherDayForecast.sunriseTime),
            WeatherInfo(title: "Sunset", icon: "wind", value: weatherDayForecast.sunsetTime),
            WeatherInfo(title: "Visibility", icon: "wind", value: UnitManager.shared.formatValueUnit(weatherDayForecast.vis, unit: .Visibility)),
            WeatherInfo(title: "Average pressure", icon: "wind", value: UnitManager.shared.formatValueUnit(weatherDayForecast.pres, unit: .Pressure)),
            WeatherInfo(title: "Average relative humidity", icon: "wind", value: UnitManager.shared.formatValueUnit(Double(weatherDayForecast.rh ?? 0), unit: .Percent)),
            WeatherInfo(title: "Max Feels Like", icon: "wind", value: UnitManager.shared.formatValueUnit(weatherDayForecast.appMaxTemp, unit: .Celcius)),
            WeatherInfo(title: "Min Feels Like", icon: "wind", value: UnitManager.shared.formatValueUnit(weatherDayForecast.appMinTemp, unit: .Celcius)),
            WeatherInfo(title: "Accumulated liquid equivalent precipitation", icon: "wind", value: UnitManager.shared.formatValueUnit(weatherDayForecast.precip, unit: .Precipitation)),

        ]
        self.data.value = (weatherMainInfo, listInfo)
        self.dataSource?.data.value = listInfo
    }
}


