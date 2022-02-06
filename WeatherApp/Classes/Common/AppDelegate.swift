//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Mouayyad Taja on 05/02/2022.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let backgroundTaskID = "MouayyadTaja.WeatherApp.refresh"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(Environment.shared.serverUrl)
        
        #if DEVELOPMENT
            print("Current environment is: Development")
        #elseif STAGING
            print("Current environment is: STAGING")
        #elseif PRODUCTION
            print("Current environment is: PRODUCTION")
        #endif
        
        //Handle local notification in foreground
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        registherAppRefresh()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func registherAppRefresh() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundTaskID, using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
    
    func scheduleAppRefresh() {
        
        let request = BGAppRefreshTaskRequest(identifier: backgroundTaskID)

        // Fetch no earlier than 30 minutes from now.
        request.earliestBeginDate = Date(timeIntervalSinceNow: 30 * 60)

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
//    func handleAppRefresh(task: BGProcessingTask) {
        scheduleAppRefresh()
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        print("Background task called")
        //Here we can upddate weather notifications
//        UIApplication.shared.applicationIconBadgeNumber = 5
//        LocalNotificationManager.shared.sendNotification()
        
        task.setTaskCompleted(success: true)
    }
    
    //Command for launch a Task from terminal
    //e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"MouayyadTaja.WeatherApp.refresh"]

    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
}

