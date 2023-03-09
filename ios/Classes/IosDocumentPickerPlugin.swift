import Flutter
import UIKit
import UniformTypeIdentifiers

enum PickerMode: Int { case file, folder }

public class IosDocumentPickerPlugin: NSObject, FlutterPlugin, UIDocumentPickerDelegate {
  var resultFn: FlutterResult?
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ios_document_picker", binaryMessenger: registrar.messenger())
    let instance = IosDocumentPickerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? Dictionary<String, Any> else {
      result(FlutterError(code: "InvalidArgsType", message: "Invalid args type", details: nil))
      return
    }
    switch call.method {
    case "pick":
      resultFn = result
      
      let mode = PickerMode(rawValue: args["type"] as! Int)
      let documentPicker =
      UIDocumentPickerViewController(forOpeningContentTypes: mode == .folder ? [UTType.folder] : [UTType.item])
      documentPicker.delegate = self

      // Present the document picker.
      currentViewController()?.present(documentPicker, animated: true, completion: nil)
      
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  private func currentViewController() -> UIViewController? {
    var keyWindow: UIWindow?
    for window in UIApplication.shared.windows {
      if window.isKeyWindow {
        keyWindow = window
        break
      }
    }
    
    var topController = keyWindow?.rootViewController
    while topController?.presentedViewController != nil {
      topController = topController?.presentedViewController
    }
    return topController
  }
  
  private func urlToMap(_ url: URL) -> [String: String] {
    return ["uri": url.absoluteString, "path": url.path]
  }
  
  public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    resultFn?(urls.map{ urlToMap($0) })
  }
  
  public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    resultFn?(nil)
  }
}
