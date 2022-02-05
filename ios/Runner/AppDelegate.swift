import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // add swift code here
      let MethodChannelName = "com.sary.juriba/toast"
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let methodChannel = FlutterMethodChannel(name: MethodChannelName, binaryMessenger: controller.binaryMessenger)
      
      methodChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult )-> Void in
          if call.method == "saryToast"
          {
              guard let arguments = call.arguments else
              {
                  return result(FlutterMethodNotImplemented)
              }
              let myArguments = arguments as? [String: Any]
              let message = myArguments?["message"]
              
               result(message);
          }else{
              result(FlutterMethodNotImplemented)
          }
      })
      
    //end swift code
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
