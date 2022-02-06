//
//  WeatherRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func fetchWeatherForecast(_ completion: @escaping ((Result<WeatherForecastCollection, Error>) -> Void))
}
