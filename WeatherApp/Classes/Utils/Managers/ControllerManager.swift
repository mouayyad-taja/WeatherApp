//
//  ControllerManager.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 05/02/2022.
//

import Foundation
import SwifterSwift

//Contains objects of exist Controllers
struct ControllerManager {

    //Contains objects of exist storyboards
    struct myStoryboard {
        //main storyboard
        static let main = UIStoryboard.init(name: "Main", bundle: nil)
    }

    
    private static func viewController<T: UIViewController>(withClass name: T.Type, storyboard: UIStoryboard) -> T{
        if let vc = storyboard.instantiateViewController(withClass: T.self){
            return vc
        }
        fatalError("Couldn't find view controlller")
    }
    
    //collection of main controllers
    struct main {
        
        static var weatherDetailsVC : WeatherDetailsVC {
            return viewController(withClass: WeatherDetailsVC.self, storyboard: myStoryboard.main)
        }
        
        static var settingsVC : SettingsVC {
            return viewController(withClass: SettingsVC.self, storyboard: myStoryboard.main)
        }
    }
}

