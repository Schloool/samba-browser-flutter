import Flutter
import UIKit
import AMSMB2

public class SwiftSambaBrowserPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "samba_browser", binaryMessenger: registrar.messenger())
    let instance = SwiftSambaBrowserPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let args = call.arguments as! [String:Any]

    switch call.method {
        case "getShareList":
            let dummy = ["Folder 1", "Folder 2"]
            
          result(getShareList(args: args))
          break

        case "saveFile":
            let dummy = "File"
            result(dummy)
            break

            default:
                result(FlutterMethodNotImplemented)
    }
  }
  
  private func getShareList(args: [String:Any]) -> [String] {
    return ["Folder 1", "File 1"]
  }

}
