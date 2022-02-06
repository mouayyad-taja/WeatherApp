//
//  UnitManager.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation

public enum UnitKey: String {
    case Fahrenheit = "I"
    case Celcius = "M"
    
    var title: String{
        switch self {
        case .Fahrenheit:
            return "F"
        case .Celcius:
            return "C"
        }
    }
}

class UnitManager{
    
    public let generalUnit :UnitKey = .Celcius
    
    private var currentUnit :UnitKey!
    
    static var shared: UnitManager {
        return UnitManager()
    }

    fileprivate init(){
        if let currentUnit = UserDefaultsManager.shared.loadObject(forKey: .tempUnit) as? String{
            self.currentUnit = UnitKey(rawValue: currentUnit)
        }else {
            self.currentUnit = .Celcius
        }
        
    }
    
    
    func calculateCelsius(fahrenheit: Double) -> Double {
        var celsius: Double
        
        celsius = (fahrenheit - 32) * 5 / 9
        
        return celsius
    }
    
    func calculateFahrenheit(celsius: Double) -> Double {
        var fahrenheit: Double
        
        fahrenheit = celsius * 9 / 5 + 32
        
        return fahrenheit
    }
    
    func getCurrentTemp(temp: Double)->String{
        var currentTemp :Double
        if currentUnit == generalUnit {
            currentTemp = temp
        }else if currentUnit == .Fahrenheit {
            currentTemp = calculateFahrenheit(celsius: temp)
        }else {
            currentTemp = calculateCelsius(fahrenheit: temp)
        }
        return "\(currentTemp) °\(currentUnit.title)"
    }
    
}
