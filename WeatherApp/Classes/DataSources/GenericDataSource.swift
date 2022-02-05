//
//  GenericDataSource.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 05/02/2022.
//

import Foundation
class GenericDataSource<T>: NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
