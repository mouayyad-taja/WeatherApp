//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import XCTest
@testable import WeatherApp

class WeatherViewModelTests: XCTestCase {

    var viewModel : WeatherForecastViewModel!
    var dataSource : GenericDataSource<WeatherForecast>!
    fileprivate var service : MockService!
    var viewModelWithWeather : WeatherForecastViewModel!
    fileprivate var serviceWithWeather : MockServiceWithWeather!

    
    override func setUp() {
        super.setUp()
        self.service = MockService()
        self.serviceWithWeather = MockServiceWithWeather()
        self.dataSource = GenericDataSource<WeatherForecast>()
        self.viewModel = WeatherForecastViewModel(dataSource: dataSource, apiService: service)
        self.viewModelWithWeather = WeatherForecastViewModel(dataSource: dataSource, apiService: serviceWithWeather)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }
    
    func testFetchWithNoService() {
        
        // giving no service to a view model
        self.viewModel = WeatherForecastViewModel(dataSource: dataSource, apiService: nil)

        // expected to not be able to fetch data
        viewModel.dataSource?.data.addObserver(self, completionHandler: { result in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        })
        viewModel.getWeatherForecastList()
    }

    
    func testFetchWeatherList() {
        // expected completion to succeed
        
        viewModel.error.addObserver(self, completionHandler: { result in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        })
        viewModelWithWeather.getWeatherForecastList()
    }
    
    func testFetchNoWeather() {

        // expected completion to fail
        viewModel.dataSource?.data.addObserver(self, completionHandler: { result in
            XCTAssert(false, "ViewModel should not be able to fetch ")
        })
        viewModel.getWeatherForecastList()
    }
    
    fileprivate class MockService : WeatherRepositoryProtocol {
        var weatherData: WeatherForecastCollection?
        
        func fetchWeatherForecast(_ completion: @escaping ((Result<WeatherForecastCollection, Error>) -> Void)) {
            if let weatherData = weatherData {
                completion(Result.success(weatherData))
            } else {
                let error = NSError(domain: "", code: -1, userInfo: [ NSLocalizedDescriptionKey: "No weatherData"])
                completion(Result.failure(error))
            }
        }
    }

    fileprivate class MockServiceWithWeather : WeatherRepositoryProtocol {
        var weatherData: WeatherForecastCollection? = WeatherForecastCollection(data: [WeatherForecast()])
        
        func fetchWeatherForecast(_ completion: @escaping ((Result<WeatherForecastCollection, Error>) -> Void)) {
            if let weatherData = weatherData {
                completion(Result.success(weatherData))
            } else {
                let error = NSError(domain: "", code: -1, userInfo: [ NSLocalizedDescriptionKey: "No weatherData"])
                completion(Result.failure(error))
            }
        }
    }

    
}
