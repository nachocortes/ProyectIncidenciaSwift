import XCTest
@testable import AppIncidencias

final class AuthManagerTests: XCTestCase {

    func testLogoutClearsSession() {
        let auth = AuthManager.shared
        auth.token = "mock_token"
        auth.tecnicoID = 42
        auth.rol = Constants.Roles.tecnico

        auth.logout()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNil(auth.token)
            XCTAssertNil(auth.tecnicoID)
            XCTAssertNil(auth.rol)
        }
    }
}
