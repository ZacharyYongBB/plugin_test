import Flutter
import UIKit
import SwiftUI
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    // Add this variable to hold location manager
    private let locationManager = CLLocationManager()
    
    override func application(_ application: UIApplication,
                              didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let batteryChannel = FlutterMethodChannel(name: "com.zachary/battery",
                                                  binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler { [weak self] (call, result) in
            switch call.method {
            case "getBatteryLevel":
                self?.receiveBatteryLevel(result: result)
            case "showSwiftUIView":
                self?.showSwiftUIView()
                result(nil) // You can provide a result if needed
            case "getLocation":
                self?.getLocation(result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func receiveBatteryLevel(result: @escaping FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        let batteryLevel = device.batteryLevel
        if batteryLevel < 0 {
            result(FlutterError(code: "UNAVAILABLE", message: "Battery level not available", details: nil))
        } else {
            result(Int(batteryLevel * 100))
        }
    }
    
    private func showSwiftUIView() {
        let hostingController = UIHostingController(rootView: LocationView())
        if let rootViewController = window?.rootViewController {
            rootViewController.present(hostingController, animated: true, completion: nil)
        }
    }
    
    private func getLocation(result: @escaping FlutterResult) {
        locationManager.requestWhenInUseAuthorization()
        let location = locationManager.location
        if let location = location {
            let locationString = "Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)"
            result(locationString)
        } else {
            result(FlutterError(code: "UNAVAILABLE", message: "Location not available", details: nil))
        }
    }
}
