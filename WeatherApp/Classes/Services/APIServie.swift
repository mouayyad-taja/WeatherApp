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
        
        self.printResponse(url: response.request?.url, data: response.data)

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
    
    public func printRequest(headers: HTTPHeaders, parameters: [String: Any]) {
        #if DEVELOPMENT
            print("===============[Headers]==================")
            do {
                if JSONSerialization.isValidJSONObject(headers){
                    let data = try JSONSerialization.data(withJSONObject: headers,                                                       options: .prettyPrinted)
                    let prettyString = String(data: data, encoding: .utf8)
                    print(prettyString ?? "")
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
            print("===============[Parameters]===============")
            do {
                if JSONSerialization.isValidJSONObject(parameters){
                    let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                    let prettyString = String(data: data, encoding: .utf8)
                    print(prettyString ?? "")
                }
            } catch {
                print(error.localizedDescription)
            }
            print("==========================================")
        #endif
    }
    
    public func printResponse(url: URL?, data: Data?) {
        #if DEVELOPMENT
            print("===============[Response]=================")
            print("From Url: \(url?.absoluteString ?? "")")
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let payload = json as? [String: Any], !payload.isEmpty {
                        print(payload)
                    }
                } catch {
                    let str = String(data: data, encoding: .utf8)
                    print(str ?? "")
                }
            }
            print("==========================================")
        #endif
    }

}


//return internet network error
extension NSError {
    class var networkError: NSError {
       return NSError(domain: "", code: -1, userInfo: [ NSLocalizedDescriptionKey: "No internet, please check your internet and try again"])
    }
}

