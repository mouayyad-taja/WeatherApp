//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation
import CoreLocation
import SwiftLocation

public struct LocationManager {
    fileprivate init() {}

    static var shared: LocationManager {
        return LocationManager()
    }
    
    func getCoordinate2D()->CLLocationCoordinate2D{
        let lat = UserDefaultsManager.shared.loadObject(forKey: .lat) as? Double
        let long = UserDefaultsManager.shared.loadObject(forKey: .long) as? Double
        let latitude = lat ?? 25.12
        let longitude = long ?? 55.21
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func updateLocation(coordinate: CLLocationCoordinate2D){
        UserDefaultsManager.shared.saveObject(coordinate.latitude, key:  .lat)
        UserDefaultsManager.shared.saveObject(coordinate.longitude, key:  .long)
    }

    func requestLocation(_ completion: @escaping ()->Void){
        SwiftLocation.gpsLocationWith {
            // configure everything about your request
            $0.subscription = .continous // continous updated until you stop it
            $0.accuracy = .house
            $0.minDistance = 1000 // updated every 300mts or more
//            $0.minInterval = 30 // updated each 30 seconds or more
            $0.activityType = .automotiveNavigation
//            $0.timeout = .delayed(0) // 5 seconds of timeout after auth granted
        }.then { result in // you can attach one or more subscriptions via `then`.
            switch result {
            case .success(let newData):
                print("New location: \(newData)")
                let coordinate = newData.coordinate
                updateLocation(coordinate: coordinate)
                completion()
            case .failure(let error):
                print("An error has occurred: \(error.localizedDescription)")
                completion()
            }
        }
    }
}
