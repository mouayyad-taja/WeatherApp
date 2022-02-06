//
//  UsderDefautlsManager.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation

public enum UserDefaultsKey: String {
    case tempUnit
}

public struct UserDefaultsManager {
    fileprivate let userDefaults = UserDefaults.standard
    fileprivate init() {}

    static var shared: UserDefaultsManager {
        return UserDefaultsManager()
    }
    
    func saveObject<T>(_ object: T?, key: UserDefaultsKey) {
        guard object != nil else { return }

        userDefaults.set(object, forKey: key.rawValue)
        userDefaults.synchronize()
        Log("💾: Successfully saved \(key.rawValue) object ✅")
    }

    func loadObject(forKey key: UserDefaultsKey) -> AnyObject? {
        if let value = userDefaults.object(forKey: key.rawValue) {
            Log("💾: Successfully loaded \(key.rawValue) object ✅")
            return value as AnyObject?
        } else {
            Log("💾: Failed to load \(key.rawValue) object ❎")
            return nil
        }
    }

    func deleteObject(forKey key: UserDefaultsKey) {
        userDefaults.removeObject(forKey: key.rawValue)
        userDefaults.synchronize()

        if !checkObject(forKey: key) {
            Log("💾: Successfully deleted \(key.rawValue) object ✅")
        } else {
            Log("💾: Failed to delete \(key.rawValue) object ❎")
        }
    }

    func checkObject(forKey key: UserDefaultsKey) -> Bool {
        if userDefaults.object(forKey: key.rawValue) != nil {
            Log("💾: \(key.rawValue) object is exist ✅")
            return true
        } else {
            Log("💾: \(key.rawValue) object is not exist ❎")
            return false
        }
    }
    
    func printAll() {
        Log("==============================================")
        Log(userDefaults.dictionaryRepresentation().debugDescription)
        Log("==============================================")
    }

}
