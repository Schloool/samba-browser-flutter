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
            getShareList(args: args, flutterResult: result)
            break
            
        case "saveFile":
            let dummy = "File"
            result(dummy)
            break
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func getShareList(args: [String:Any], flutterResult: @escaping FlutterResult) {
        SMBClient(url: "", share: "", user: "", password: "").listDirectory(path: "", handler: { result in
            switch result {
            case .success(let shares):
                flutterResult(shares)
            case .failure(let error):
                flutterResult(["ERROR :("])
            }
        })

        //return ["Folder 1", "File 1"]
    }
    
}
