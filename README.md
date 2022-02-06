# WeatherApp


A simple app to preview 16 day forecast and:
* Show a list of weather forecast
* Shows weather details. 
* Shows settings view to change from Centigrade to Fahrenheit and vice versa. 
* Offline/Local storage using Realm Framework.
* Local Notifications to show weather alert in each morning and night.


I am using the 16 Day Weather Forecast of this API.
https://api.weatherbit.io/v2.0/forecast/daily?key=[api-key]&days=[days]&lat=[latitude]&lon=[longitude]&units=M sample-key To test this API, 
For testAPI I used 
* latitude and longitude for current user location
* 16 for days
* a specified api-key e9d258e0555142618aabc4f395b62dce


&nbsp; 

**App Flow:**

&nbsp; 
&nbsp; 

https://user-images.githubusercontent.com/42350093/152697746-600be3b6-88aa-419c-ae85-f4feaae7c459.mov

&nbsp; 
&nbsp;


## Tools And Resources Used
- [CocoaPods](https://cocoapods.org/) - CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. It has over 33 thousand libraries and is used in over 2.2 million apps. CocoaPods can help you scale your projects elegantly.


## Library Used
- [RealmSwift](https://github.com/realm/realm-swift) - Realm is a mobile database that runs directly inside phones, tablets or wearables. This repository holds the source code for the iOS, macOS, tvOS & watchOS versions of Realm Swift & Realm Objective-C.
- [ReachabilitySwift](https://github.com/ashleymills/Reachability.swift) - Reachability.swift is a replacement for Apple's Reachability sample, re-written in Swift with closures.
- [Alamofire ](https://github.com/Alamofire/Alamofire) - Alamofire is an HTTP networking library written in Swift.
- [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift) - SwifterSwift is a collection of over 500 native Swift extensions, with handy methods, syntactic sugar, and more.
- [SwiftLocation](https://github.com/malcommac/SwiftLocation) - SwiftLocation is a lightweight Swift Library that provides an easy way to work with location-related functionalities.


&nbsp;


# Installation

* Installation by cloning the repository
* Go to directory
* Open terminal located at this directory
* Enter "pod install" command to install all used libraries
* Open WeatherApp.xcworkspace project
* use command + B or Product -> Build to build the project
* Press run icon in Xcode or command + R to run the project on Simulator

&nbsp; 
&nbsp; 


# Architecture

I used MVVM pattern:

&nbsp; 
&nbsp; 
![MVVM](https://user-images.githubusercontent.com/42350093/150475386-464a173a-0556-482a-b9d0-23829e3e7095.png)


</br>
</br>
