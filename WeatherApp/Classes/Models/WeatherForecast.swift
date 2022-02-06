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
    var moonriseTs: Int?
    var windCdir: String?
    var rh: Int?
    var pres, highTemp: Double?
    var sunsetTs: Int?
    var ozone, moonPhase, windGustSpd, snowDepth: Double?
    var clouds, ts, sunriseTs: Int?
    var appMinTemp, windSpd: Double?
    var pop: Int?
    var windCdirFull: String?
    var slp, moonPhaseLunation: Double?
    var validDate: String?
    var appMaxTemp, vis, dewpt: Double?
    var snow, uv: Double?
    var weather: Weather?
    var windDir, cloudsHi: Int?
    var precip, lowTemp, maxTemp: Double?
    var moonsetTs: Int?
    var datetime: String?
    var temp, minTemp: Double?
    var cloudsMid, cloudsLow: Int?

    enum CodingKeys: String, CodingKey {
        case moonriseTs = "moonrise_ts"
        case windCdir = "wind_cdir"
        case rh, pres
        case highTemp = "high_temp"
        case sunsetTs = "sunset_ts"
        case ozone
        case moonPhase = "moon_phase"
        case windGustSpd = "wind_gust_spd"
        case snowDepth = "snow_depth"
        case clouds
        case sunriseTs = "sunrise_ts"
        case appMinTemp = "app_min_temp"
        case windSpd = "wind_spd"
        case pop
        case windCdirFull = "wind_cdir_full"
        case slp
        case moonPhaseLunation = "moon_phase_lunation"
        case validDate = "valid_date"
        case appMaxTemp = "app_max_temp"
        case vis, dewpt, snow, uv, weather
        case windDir = "wind_dir"
        case cloudsHi = "clouds_hi"
        case precip
        case lowTemp = "low_temp"
        case maxTemp = "max_temp"
        case moonsetTs = "moonset_ts"
        case datetime, temp
        case minTemp = "min_temp"
        case cloudsMid = "clouds_mid"
        case cloudsLow = "clouds_low"
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
        moonriseTs: Int?? = nil,
        windCdir: String?? = nil,
        rh: Int?? = nil,
        pres: Double?? = nil,
        highTemp: Double?? = nil,
        sunsetTs: Int?? = nil,
        ozone: Double?? = nil,
        moonPhase: Double?? = nil,
        windGustSpd: Double?? = nil,
        snowDepth: Double?? = nil,
        clouds: Int?? = nil,
        ts: Int?? = nil,
        sunriseTs: Int?? = nil,
        appMinTemp: Double?? = nil,
        windSpd: Double?? = nil,
        pop: Int?? = nil,
        windCdirFull: String?? = nil,
        slp: Double?? = nil,
        moonPhaseLunation: Double?? = nil,
        validDate: String?? = nil,
        appMaxTemp: Double?? = nil,
        vis: Double?? = nil,
        dewpt: Double?? = nil,
        snow: Double?? = nil,
        uv: Double?? = nil,
        weather: Weather?? = nil,
        windDir: Int?? = nil,
        cloudsHi: Int?? = nil,
        precip: Double?? = nil,
        lowTemp: Double?? = nil,
        maxTemp: Double?? = nil,
        moonsetTs: Int?? = nil,
        datetime: String?? = nil,
        temp: Double?? = nil,
        minTemp: Double?? = nil,
        cloudsMid: Int?? = nil,
        cloudsLow: Int?? = nil
    ) -> WeatherForecast {
        return WeatherForecast(
            moonriseTs: moonriseTs ?? self.moonriseTs,
            windCdir: windCdir ?? self.windCdir,
            rh: rh ?? self.rh,
            pres: pres ?? self.pres,
            highTemp: highTemp ?? self.highTemp,
            sunsetTs: sunsetTs ?? self.sunsetTs,
            ozone: ozone ?? self.ozone,
            moonPhase: moonPhase ?? self.moonPhase,
            windGustSpd: windGustSpd ?? self.windGustSpd,
            snowDepth: snowDepth ?? self.snowDepth,
            clouds: clouds ?? self.clouds,
            ts: ts ?? self.ts,
            sunriseTs: sunriseTs ?? self.sunriseTs,
            appMinTemp: appMinTemp ?? self.appMinTemp,
            windSpd: windSpd ?? self.windSpd,
            pop: pop ?? self.pop,
            windCdirFull: windCdirFull ?? self.windCdirFull,
            slp: slp ?? self.slp,
            moonPhaseLunation: moonPhaseLunation ?? self.moonPhaseLunation,
            validDate: validDate ?? self.validDate,
            appMaxTemp: appMaxTemp ?? self.appMaxTemp,
            vis: vis ?? self.vis,
            dewpt: dewpt ?? self.dewpt,
            snow: snow ?? self.snow,
            uv: uv ?? self.uv,
            weather: weather ?? self.weather,
            windDir: windDir ?? self.windDir,
            cloudsHi: cloudsHi ?? self.cloudsHi,
            precip: precip ?? self.precip,
            lowTemp: lowTemp ?? self.lowTemp,
            maxTemp: maxTemp ?? self.maxTemp,
            moonsetTs: moonsetTs ?? self.moonsetTs,
            datetime: datetime ?? self.datetime,
            temp: temp ?? self.temp,
            minTemp: minTemp ?? self.minTemp,
            cloudsMid: cloudsMid ?? self.cloudsMid,
            cloudsLow: cloudsLow ?? self.cloudsLow
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
struct Weather: Codable {
    var icon: String?
    var code: Int?
    var weatherDescription: String?

    enum CodingKeys: String, CodingKey {
        case icon, code
        case weatherDescription = "description"
    }
}

// MARK: Weather convenience initializers and mutators

extension Weather {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Weather.self, from: data)
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
    ) -> Weather {
        return Weather(
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
