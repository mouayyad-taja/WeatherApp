//
//  WeatherForecastCollection.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation

// MARK: - WeatherForecastCollection
struct WeatherForecastCollection: Codable {
    var data: [WeatherForecast]?
    var cityName: String?
    var lon: Double?
    var timezone: String?
    var lat: Double?
    var countryCode, stateCode: String?

    enum CodingKeys: String, CodingKey {
        case data
        case cityName = "city_name"
        case lon, timezone, lat
        case countryCode = "country_code"
        case stateCode = "state_code"
    }
}

// MARK: WeatherForecastCollection convenience initializers and mutators

extension WeatherForecastCollection {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WeatherForecastCollection.self, from: data)
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
        data: [WeatherForecast]?? = nil,
        cityName: String?? = nil,
        lon: Double?? = nil,
        timezone: String?? = nil,
        lat: Double?? = nil,
        countryCode: String?? = nil,
        stateCode: String?? = nil
    ) -> WeatherForecastCollection {
        return WeatherForecastCollection(
            data: data ?? self.data,
            cityName: cityName ?? self.cityName,
            lon: lon ?? self.lon,
            timezone: timezone ?? self.timezone,
            lat: lat ?? self.lat,
            countryCode: countryCode ?? self.countryCode,
            stateCode: stateCode ?? self.stateCode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
