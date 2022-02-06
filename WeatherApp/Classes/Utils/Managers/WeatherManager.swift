//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation
import RealmSwift

class WeatherManager{
    
    static let shared = WeatherManager()
    
    fileprivate init(){
    }
    
    var weatherRealm: Realm{
        // Open the realm with a specific file URL, for example a username
        let type = "Weather"
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL!.deleteLastPathComponent()
        config.fileURL!.appendPathComponent(type)
        config.fileURL!.appendPathExtension("realm")
        let realm = try! Realm(configuration: config)
        return realm
    }
    
    func fetchWeatherForecastList(_ completion: @escaping ((Result<[WeatherForecast], Error>) -> Void)){
        // Open the local-only default realm
        let storableWeatherList = weatherRealm.objects(StorableWeatherForecast.self)
        
        let weatherList = storableWeatherList.compactMap{ ($0).model }
        
        Log("💾: Successfully realm fetched \(weatherList.count) weather items ✅")

        completion(.success(Array(weatherList)))
    }
    
    func removeAllWeatherForecast(){
        do {
            try weatherRealm.write {
                weatherRealm.deleteAll()
            }
        } catch let error as NSError {
            // Handle error
            print(error)
        }
    }
    
    func saveWeatherList(weatherList :[WeatherForecast]){
        do {
            let storableWeatherList = weatherList.compactMap{ ($0).toStorable() }

            try  weatherRealm.write {
                weatherRealm.add(storableWeatherList)
            }
            Log("💾: Successfully realm saved \(weatherList.count) weather items ✅")

        } catch let error as NSError {
            // Handle error
            print("addWishlistProduct")
            print(error)
        }
        
    }
}
