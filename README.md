# BundleIDSpoofer

```swift
XCTAssertEqual(Bundle.main.bundleIdentifier, "com.apple.dt.xctest.tool")
BundleIDSpoofer.spoof(bundleID: "com.apple.Preferences") {
  XCTAssertEqual(Bundle.main.bundleIdentifier, "com.apple.Preferences")
}
XCTAssertEqual(Bundle.main.bundleIdentifier, "com.apple.dt.xctest.tool")
```
