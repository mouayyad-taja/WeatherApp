//
//  WeatherRemoteRepository.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation
import Alamofire
import Reachability

final class WeatherRemoteRepository : WeatherRepository {
        
    let baseService = APIServie()
    
    // API URLS
    let API_URL: String = Environment.shared.serverUrl + "/v2.0/forecast/daily"
    
    var request : DataRequest?
    
    //Get weather forecast
    func fetchWeatherForecast(_ completion: @escaping ((Result<WeatherForecastCollection, Error>) -> Void)) {
        
        // cancel previous request if already in progress
        self.cancelLastRequest()
        
        let apiKey = Environment.shared.weatherAPIKey
        let daysNumber = 16
        let unit = UnitManager.shared.generalUnit.rawValue
        let location =  LocationManager.shared.getCoordinate2D()
        
        let parameters: [String : Any] = [
            "key": apiKey,
            "days": daysNumber,
            "lat": location.latitude,
            "lon": location.longitude,
            "units": unit,
        ]
        
        self.request = AF.request(API_URL, method: .get, parameters: parameters)
        
        do {
            let reachability = try Reachability()
            if reachability.connection == .unavailable {
                let error = NSError.networkError
                completion(.failure(error))
                return
            }
        }
        catch(let error){
            print(error)
        }
        

        request?.responseDecodable(of: WeatherForecastCollection.self){ (response) in
            self.baseService.printRequest(headers: response.request?.headers ?? [:], parameters: parameters)


            self.baseService.handleResponse(response: response, { result in
                switch result {
                case .success(let data):
                    completion(Result.success(data))
                case .failure(let error):
                    completion(Result.failure(error))
                    return
                }
            })
            
        }
    }
    
    func cancelLastRequest() {
        if let task = request {
            task.cancel()
        }
        request = nil
    }
    
}
