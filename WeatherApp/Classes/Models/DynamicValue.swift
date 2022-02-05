//
//  DynamicValue.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 05/02/2022.
//

import Foundation

class DynamicValue<T> {
    
    typealias CompletionHandler = ((T) -> Void)
    
    var value : T {
        didSet {
            self.notify()
        }
    }
    
    private var observers = [String: CompletionHandler]()
    
    init(_ value: T) {
        self.value = value
    }
    
    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    public func removeObserver(_ observer: NSObject) {
        if let index = observers.keys.firstIndex(of: observer.description){
            observers.remove(at: index)
        }
    }
    
    public func addAndNotify(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify() {
        observers.forEach({ $0.value(value) })
    }
    
    func forceNotify() {
        observers.forEach({ $0.value(value) })
    }
    
    deinit {
        observers.removeAll()
    }
}

