//
//  UnitManager.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation

public enum UnitKey: String, Codable {
    case Fahrenheit = "I"
    case Celcius = "M"
    case WindSpeed = "m/s"
    case Visibility = "KM"
    case Pressure = "mb"
    case Percent = "%"
    case Precipitation = "mm"
    
    var title: String{
        switch self {
        case .Fahrenheit:
            return "F"
        case .Celcius:
            return "C"
        default:
            return self.rawValue
        }
    }
    
    static let tempUnits :[UnitKey] = [.Celcius, .Fahrenheit]
}

class UnitManager{
    
    public let generalUnit :UnitKey = .Celcius
    
    public private(set) var currentUnit :UnitKey!
    
    static var shared: UnitManager {
        return UnitManager()
    }

    fileprivate init(){
        if let currentUnit = UserDefaultsManager.shared.loadObject(forKey: .tempUnit) as? String{
            self.currentUnit = UnitKey(rawValue: currentUnit)
        }else {
            self.currentUnit = .Celcius
            UserDefaultsManager.shared.saveObject(self.currentUnit.rawValue, key: .tempUnit)
        }
    }
    
    func updateUnit(unit: UnitKey){
        UserDefaultsManager.shared.saveObject(unit.rawValue, key: .tempUnit)
        currentUnit = unit
        broadcastUnit(unit: currentUnit)
    }
    
    private func broadcastUnit(unit: UnitKey){
        NotificationCenter.default.post(name: .didUpdateUnit, object: unit)
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
        
        return "\(String(format: "%.2f", currentTemp)) °\(currentUnit.title)"
    }
    
    func formatValueUnit(_ value: Double?, unit: UnitKey)->String{
        return "\(value ?? 0) \(unit.title)"
    }
}


//Define a new types of Notification
extension Notification.Name {
    static let didUpdateUnit = Notification.Name("didUpdateUnit")
}
