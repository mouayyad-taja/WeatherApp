//
//  Environment.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 05/02/2022.
//

import Foundation

public struct Environment {
    static private var env = Environment()
    
    static var shared:Environment {
        get{
            return env
        }
    }
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    
    var serverUrl: String {
        return infoDict["WEATHER_BASE_URL"] as! String
    }
    var host: String {
        return infoDict["APP_HOST"] as! String
    }    
}
