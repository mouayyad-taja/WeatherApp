//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation
import CoreLocation

public struct LocationManager {
    fileprivate init() {}

    static var shared: LocationManager {
        return LocationManager()
    }
    
    func getCoordinate2D()->CLLocationCoordinate2D{
        let long = 55.21
        let lat = 25.12
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }

}
