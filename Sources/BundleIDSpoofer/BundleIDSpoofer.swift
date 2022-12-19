import Foundation
import ObjectiveC

@MainActor
public class BundleIDSpoofer {
  static var bundleID: String = "com.apple.SpringBoard"
  
  @MainActor
  public static func spoof(bundleID: String, closure: () throws -> Void) rethrows {
    Self.bundleID = bundleID
    swizzle()
    try closure()
    swizzle()
  }
  
  static func swizzle() {
    let original = #selector(getter: Bundle.self.bundleIdentifier)
    let swizzled = #selector(getter: Self.swizzledBundleIdentifier)
    let originalMethod = class_getInstanceMethod(Bundle.self, original)!
    let swizzledMethod = class_getInstanceMethod(BundleIDSpoofer.self, swizzled)!
    
    let didAddViewDidLoadMethod = class_addMethod(
      Bundle.self,
      original,
      method_getImplementation(swizzledMethod),
      method_getTypeEncoding(swizzledMethod)
    )
    
    if didAddViewDidLoadMethod {
      class_replaceMethod(
        Bundle.self,
        swizzled,
        method_getImplementation(originalMethod),
        method_getTypeEncoding(originalMethod)
      )
    } else {
      method_exchangeImplementations(originalMethod, swizzledMethod)
    }
  }
  
  @objc var swizzledBundleIdentifier: String? {
    Self.bundleID
  }
}
