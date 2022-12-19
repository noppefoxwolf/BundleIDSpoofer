import XCTest
@testable import BundleIDSpoofer

final class BundleIDSpooferTests: XCTestCase {
  func testExample() async throws {
    XCTAssertEqual(Bundle.main.bundleIdentifier, "com.apple.dt.xctest.tool")
    await BundleIDSpoofer.spoof(bundleID: "com.apple.Preferences") {
      XCTAssertEqual(Bundle.main.bundleIdentifier, "com.apple.Preferences")
    }
    XCTAssertEqual(Bundle.main.bundleIdentifier, "com.apple.dt.xctest.tool")
  }
}
