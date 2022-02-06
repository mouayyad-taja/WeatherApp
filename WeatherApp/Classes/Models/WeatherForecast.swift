//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 05/02/2022.
//

import Foundation
import AFDateHelper

// MARK: - WeatherForecast
struct WeatherForecast: Codable {
    var rh: Int?
    var pres, highTemp: Double?
    var sunsetTs: Int?
    var sunriseTs: Int?
    var appMinTemp, windSpd: Double?
    var windCdirFull: String?
    var appMaxTemp, vis: Double?
    var weather: WeatherDetails?
    var precip, lowTemp: Double?
    var datetime: String?
    var temp: Double?

    enum CodingKeys: String, CodingKey {
        case rh, pres
        case highTemp = "high_temp"
        case sunsetTs = "sunset_ts"
        case sunriseTs = "sunrise_ts"
        case appMinTemp = "app_min_temp"
        case windSpd = "wind_spd"
        case windCdirFull = "wind_cdir_full"
        case appMaxTemp = "app_max_temp"
        case vis, weather
        case precip
        case lowTemp = "low_temp"
        case datetime, temp
    }
    
    lazy var dayDate: String = {
        if let dateStr = datetime {
            if let date = Date.init(fromString: dateStr, format: .isoDate){
                return date.toString(format: .custom("EEE\ndd MM"))
            }
        }
        return datetime ?? ""
    }()
    
    var sunriseTime: String {
        if let value = sunriseTs {
            let sunriseTs = Double(value)
            let date = Date(timeIntervalSince1970: sunriseTs)
            return date.toString(format: .custom("HH:mm a"))
        }
        return datetime ?? ""
    }
    
    var sunsetTime: String {
        if let value = sunsetTs {
            let sunsetTs = Double(value)
            let date = Date(timeIntervalSince1970: sunsetTs)
            return date.toString(format: .custom("HH:mm a"))
        }
        return datetime ?? ""
    }
    
    func getWeatherInfo()->[WeatherInfo]{
        return [
            WeatherInfo(title: "Wind speed", icon: "wind", value: UnitManager.shared.formatValueUnit(self.windSpd, unit: .WindSpeed)),
            WeatherInfo(title: "Wind direction", icon: "wind", value: self.windCdirFull),
            WeatherInfo(title: "Sunrise", icon: "sunrise", value: self.sunriseTime),
            WeatherInfo(title: "Sunset", icon: "sunset", value: self.sunsetTime),
            WeatherInfo(title: "Visibility", icon: "eye.fill", value: UnitManager.shared.formatValueUnit(self.vis, unit: .Visibility)),
            WeatherInfo(title: "Average pressure", icon: "stopwatch.fill", value: UnitManager.shared.formatValueUnit(self.pres, unit: .Pressure)),
            WeatherInfo(title: "Average relative humidity", icon: "humidity", value: UnitManager.shared.formatValueUnit(Double(self.rh ?? 0), unit: .Percent)),
            WeatherInfo(title: "Max Feels Like", icon: "thermometer", value: UnitManager.shared.formatValueUnit(self.appMaxTemp, unit: .Celcius)),
            WeatherInfo(title: "Min Feels Like", icon: "thermometer", value: UnitManager.shared.formatValueUnit(self.appMinTemp, unit: .Celcius)),
            WeatherInfo(title: "Accumulated liquid equivalent precipitation", icon: "aqi.medium", value: UnitManager.shared.formatValueUnit(self.precip, unit: .Precipitation)),
        ]

    }
}

// MARK: WeatherForecast convenience initializers and mutators

extension WeatherForecast {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WeatherForecast.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        rh: Int?? = nil,
        pres: Double?? = nil,
        highTemp: Double?? = nil,
        sunsetTs: Int?? = nil,
        sunriseTs: Int?? = nil,
        appMinTemp: Double?? = nil,
        windSpd: Double?? = nil,
        windCdirFull: String?? = nil,
        appMaxTemp: Double?? = nil,
        vis: Double?? = nil,
        weather: WeatherDetails?? = nil,
        precip: Double?? = nil,
        lowTemp: Double?? = nil,
        datetime: String?? = nil,
        temp: Double?? = nil
    ) -> WeatherForecast {
        return WeatherForecast(
            rh: rh ?? self.rh,
            pres: pres ?? self.pres,
            highTemp: highTemp ?? self.highTemp,
            sunsetTs: sunsetTs ?? self.sunsetTs,
            sunriseTs: sunriseTs ?? self.sunriseTs,
            appMinTemp: appMinTemp ?? self.appMinTemp,
            windSpd: windSpd ?? self.windSpd,
            windCdirFull: windCdirFull ?? self.windCdirFull,
            appMaxTemp: appMaxTemp ?? self.appMaxTemp,
            vis: vis ?? self.vis,
            weather: weather ?? self.weather,
            precip: precip ?? self.precip,
            lowTemp: lowTemp ?? self.lowTemp,
            datetime: datetime ?? self.datetime,
            temp: temp ?? self.temp
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Weather
struct WeatherDetails: Codable {
    var icon: String?
    var code: Int?
    var weatherDescription: String?

    enum CodingKeys: String, CodingKey {
        case icon, code
        case weatherDescription = "description"
    }
}

// MARK: Weather convenience initializers and mutators

extension WeatherDetails {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WeatherDetails.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        icon: String?? = nil,
        code: Int?? = nil,
        weatherDescription: String?? = nil
    ) -> WeatherDetails {
        return WeatherDetails(
            icon: icon ?? self.icon,
            code: code ?? self.code,
            weatherDescription: weatherDescription ?? self.weatherDescription
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
