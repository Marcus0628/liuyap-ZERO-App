import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAMEoyCG4NwoTOeD6uj1SXAQ0U-24gDaI4")
    
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback{(registry) in GeneratedPluginRegistrant.register(with: registry)}
    
    GeneratedPluginRegistrant.register(with: self)

    if #available(iOS 10.0, *){
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

