//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation
import Reachability

class WeatherRepository: WeatherRepositoryProtocol {
    
    private let remoteRepostiory = WeatherRemoteRepository()
    private let localRepostiory = WeatherLocalRepository()
    
    //Get weather forecast
    func fetchWeatherForecast(_ completion: @escaping ((Result<WeatherForecastCollection, Error>) -> Void)) {
        
        do {
            let reachability = try Reachability()
            if reachability.connection == .unavailable {
                let error = NSError.networkError
                fetchLocalWeatherForecast(error: error, completion)
                return
            }
        }
        catch(let error){
            print(error)
        }
        
        remoteRepostiory.fetchWeatherForecast { result in
            switch result {
            case .success(let data):
                self.localRepostiory.saveWeatherForecast(collection: data)
                completion(.success(data))
            case .failure(let error):
                self.fetchLocalWeatherForecast(error: error, completion)
            }
        }
        
    }
    
    private func fetchLocalWeatherForecast(error: Error, _ completion: @escaping ((Result<WeatherForecastCollection, Error>) -> Void)){
        localRepostiory.fetchWeatherForecast{ result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let _):
                completion(.failure(error))
            }
        }
    }
}
