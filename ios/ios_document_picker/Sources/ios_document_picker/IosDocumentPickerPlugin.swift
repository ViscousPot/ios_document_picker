import Flutter
import UIKit
import UniformTypeIdentifiers

enum PickerMode: Int { case file, folder }

public class IosDocumentPickerPlugin: NSObject, FlutterPlugin, UIDocumentPickerDelegate {
  var resultFn: FlutterResult?

  private var resolvedUrls: [String: URL] = [:];

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "ios_document_picker", binaryMessenger: registrar.messenger())
    let instance = IosDocumentPickerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any] else {
      result(FlutterError(code: "InvalidArgsType", message: "Invalid args type", details: nil))
      return
    }
    switch call.method {
    case "pick":
      resultFn = result

      let mode = PickerMode(rawValue: args["type"] as! Int)
      let allowsMultiple = args["multiple"] as? Bool ?? false
      let allowedUtiTypes = args["allowedUtiTypes"] as? [String]

      let utTypes = allowedUtiTypes?.compactMap { UTType($0) }

      let documentPicker =
        UIDocumentPickerViewController(
          forOpeningContentTypes: utTypes ?? (mode == .folder ? [UTType.folder] : [UTType.data]))
      documentPicker.delegate = self
      documentPicker.allowsMultipleSelection = allowsMultiple

      currentViewController()?.present(documentPicker, animated: true, completion: nil)
    case "resolveBookmark":
      guard let bookmark64 = args["bookmark"] as? String,
        let bookmark = Data.init(base64Encoded: bookmark64) else {
        result(FlutterError(code: "InvalidArguments", message: "expected bookmark argument to be string.", details: nil))
        return
      }
      do {
        var isStale: Bool = false
        let url = try URL(resolvingBookmarkData: bookmark, options: [], relativeTo: nil, bookmarkDataIsStale: &isStale)
        print("resolved bookmark to: \(url) (\(isStale))")
        if (url.isFileURL) {
          resolvedUrls[url.path] = url
          result(url.path)
        } else {
          result(FlutterError(code: "InvalidBookmark", message: "Bookmark is no file url. \(url)", details: nil))
          return
        }
      } catch {
        result(FlutterError(code: "UnexpectedError", message: "Error while resolving bookmark \(error)", details: nil))
      }
    // case "startAccessingSecurityScopedResourceWithBookmark":
    //   // if let urlStr = call.arguments as? String,
    //       let url = URL(string: urlStr) {
    //     let success = url.startAccessingSecurityScopedResource()
    //     result(success)
    //   } else {
    //     result(false)
    //   }
    // case "stopAccessing":
    //   if let urlStr = call.arguments as? String,
    //     let url = URL(string: urlStr) {
    //     url.stopAccessingSecurityScopedResource()
    //     result(nil)
    //   } else {
    //     result(FlutterError(code: "INVALID_URL", message: "Invalid URL", details: nil))
    //   } 
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
      let bookmark: String
      do {
        let data = try url.bookmarkData(options: [], includingResourceValuesForKeys: nil, relativeTo: nil)
        bookmark = data.base64EncodedString()
      } catch {
        bookmark = ""
      }
      return ["url": url.absoluteString, "path": url.path, "name": url.lastPathComponent, "bookmark": bookmark.base64EncodedString()]
  }

  public func documentPicker(
    _ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]
  ) {
    resultFn?(urls.map { urlToMap($0) })
  }

  public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    resultFn?(nil)
  }
}
