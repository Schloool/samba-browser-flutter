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
            saveFile(args: args, flutterResult: result)
            break
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func getShareList(args: [String:Any], flutterResult: @escaping FlutterResult) {
        
        var url: String = args["url"] as! String
        
         if url.last == "/" {
             url = String(url.dropLast())
         }
        
        let user: String = args["username"] as! String
        let password: String = args["password"] as! String
        
        // the last component of the url has to be extracted separately as the share string must not be empty
        let share: String = url.components(separatedBy: "/").last!
        
        SMBClient(url: url, share: share, user: user, password: password).listDirectory(path: "", handler: { result in
            switch result {
            case .success(let shares):
                flutterResult(shares)
            case .failure(let error):
                flutterResult(FlutterError(code: "An error occurred", message: error.localizedDescription, details: nil))
            }
        })
    }
    
    private func saveFile(args: [String:Any], flutterResult: @escaping FlutterResult) {
        
        let url: String = args["url"] as! String
        // the last component of the url has to be extracted separately as the share string must not be empty
        let share: String = url.components(separatedBy: "/").last!
        let user: String = args["username"] as! String
        let password: String = args["password"] as! String
        
        SMBClient(url: url, share: share, user: user, password: password).downloadFile(path: "", to: "", handler: { result in
            switch result {
            case .success(let shares):
                flutterResult(shares)
            case .failure(let error):
                flutterResult(FlutterError(code: "An error occurred", message: error.localizedDescription, details: nil))
            }
        })
    }
    
}
