//
//  WeatherLocalRepository.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation


public protocol Entity {
    associatedtype StoreType: Storable
    
    func toStorable() -> StoreType
}

public protocol Storable {
    associatedtype EntityObject: Entity
    
    var model: EntityObject { get }
    var uuid: String { get }
}

final class WeatherLocalRepository : WeatherRepositoryProtocol {
    
    func fetchWeatherForecast(_ completion: @escaping ((Result<WeatherForecastCollection, Error>) -> Void)) {
        WeatherManager.shared.fetchWeatherForecastList { result in
            switch result {
            case .success(let weatherList):
                let cityName = UserDefaultsManager.shared.loadObject(forKey: .cityName) as? String
                let lat = UserDefaultsManager.shared.loadObject(forKey: .lat) as? Double
                let long = UserDefaultsManager.shared.loadObject(forKey: .long) as? Double
                let collection = WeatherForecastCollection(data: weatherList, cityName: cityName, lon: long, lat: lat)
                completion(.success(collection))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func saveWeatherForecast(collection: WeatherForecastCollection) {
        //remove old weather forecast list
        WeatherManager.shared.removeAllWeatherForecast()

        //save main info
        UserDefaultsManager.shared.saveObject(collection.cityName, key: .cityName)
        UserDefaultsManager.shared.saveObject(collection.lat, key: .lat)
        UserDefaultsManager.shared.saveObject(collection.lon, key: .long)
        
        //save new weather forecast list
        WeatherManager.shared.saveWeatherList(weatherList: collection.data ?? [])
    }
}
