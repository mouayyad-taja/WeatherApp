//
//  LocalNotificationManager.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import Foundation
import UserNotifications
import AFDateHelper

class LocalNotificationManager{
    
    static let shared = LocalNotificationManager()
    
    fileprivate init(){
        
    }
    
    
    // Notification center property
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    func scheduleNotifications(weatherList: [WeatherForecast]){
        requestNotificationAuthorization()
        cancelAllNotifications()
        
        for i in 0..<weatherList.count{
            let weather = weatherList[i]
            if i > 2 {
                break
            }
            sendNotification(weather: weather, night: false)
            sendNotification(weather: weather, night: true)
        }
//        sendNotification()
    }
    
    func cancelAllNotifications(){
//        center.removeAllDeliveredNotifications() // To remove all delivered notifications
        userNotificationCenter.removeAllPendingNotificationRequests()
    }
    
    func requestNotificationAuthorization() {
        // Auth options
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    func sendNotification(weather: WeatherForecast, night: Bool = false) {
        // Create new notifcation content instance
        let notificationContent = UNMutableNotificationContent()
        
        let temp = night ? weather.lowTemp : weather.highTemp
        
        // Add the content to the notification content
        notificationContent.title = "Weather Today"
        notificationContent.body = "Current Temp is " + UnitManager.shared.getCurrentTemp(temp: temp ?? 0)
        notificationContent.sound = .default
                
        guard let date = weather.date else {return}
        
        var dateComponents = Calendar.current.dateComponents([.day, .year, .month], from: date)
        let day = dateComponents.day
        let month = dateComponents.month

        let dayHour = 8
        let nightHour = 20
        dateComponents.hour = night ? nightHour : dayHour
        dateComponents.minute = 0

        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let identifier = "weatherNotification-\(day!)-\(month!)\(night ? "N" : "M")"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: notificationContent,
                                            trigger: notificationTrigger)
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
        
    }
    
    func sendNotification() {
        // Create new notifcation content instance
        let notificationContent = UNMutableNotificationContent()
                
        // Add the content to the notification content
        notificationContent.title = "Weather Today"
        notificationContent.body = "Test local notification"
        notificationContent.sound = .default
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: notificationTrigger)
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
        
    }
    

}
