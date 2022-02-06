# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

use_frameworks!

def default_pods

  # Comment the next line if you don't want to use dynamic frameworks

  # Pods for WeatherApp
  pod 'Alamofire'
  pod 'SwifterSwift'
  pod 'SDWebImage', '~> 4.0'
  pod 'ReachabilitySwift'
  pod 'RealmSwift'
  pod 'AFDateHelper'
  pod 'SwiftLocation/Core'

end

target 'WeatherApp' do
  default_pods
  
  target 'WeatherAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'WeatherAppUITests' do
    # Pods for testing
  end
end

target 'WeatherApp Staging' do
  default_pods
end

target 'WeatherApp Production' do
  default_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name == 'Test'
                config.build_settings['ENABLE_TESTABILITY'] = 'YES'
            end
        end
    end
end
