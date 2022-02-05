//
//  APIServie.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 05/02/2022.
//

import Foundation
import Alamofire

public typealias ResultHandler<T> = (Result<T, Error>)->Void

final class APIServie {
    
    //validate response status
    func handleResponse<T>(response: AFDataResponse<T>,  _ completion: (ResultHandler<T>?)){
        
        let statusCode = response.response?.statusCode
        
        //response is failed
        if statusCode != 200 {
            let error = NSError(domain: "", code: statusCode ?? -1, userInfo: [ NSLocalizedDescriptionKey: "Something is wrong"])
            completion?(.failure(error))
            return
        }
        
        switch response.result {
        case .failure(let error):
            completion?(Result.failure(error))
            return
        case .success(let data):
            completion?(Result.success(data))
        }
    }
}


//return internet network error
extension NSError {
    class var networkError: NSError {
       return NSError(domain: "", code: -1, userInfo: [ NSLocalizedDescriptionKey: "No internet, please check your internet and try again"])
    }
}

