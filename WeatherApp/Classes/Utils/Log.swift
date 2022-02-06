//
//  Log.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation

public enum LogType: String {
    case debug = "DEBUG", info = "INFO", error = "ERROR"
}

public func Log(_ items: Any?, type: LogType = .debug) {
    #if DEVELOPMENT
        print("\(type.rawValue): \(items ?? String(describing: items))")
    #elseif STAGING
        print("\(type.rawValue): \(items ?? String(describing: items))")
    #endif
}
