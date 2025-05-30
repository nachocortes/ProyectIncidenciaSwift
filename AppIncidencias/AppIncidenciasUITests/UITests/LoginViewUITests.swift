import XCTest
import SwiftUI
@testable import AppIncidencias

final class LoginViewUITests: XCTestCase {

    func testLoginViewRenders() {
        let view = LoginView().environmentObject(AuthManager.shared)
        let hosting = UIHostingController(rootView: view)

        XCTAssertNotNil(hosting.view)
    }
}
