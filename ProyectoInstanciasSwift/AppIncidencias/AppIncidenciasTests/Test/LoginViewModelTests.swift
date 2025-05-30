import XCTest
@testable import AppIncidencias

final class LoginViewModelTests: XCTestCase {

    func testEmptyCredentialsShowError() {
        let viewModel = LoginViewModel()
        viewModel.email = ""
        viewModel.password = ""
        viewModel.login()

        XCTAssertEqual(viewModel.errorMessage, "Correo y contraseña obligatorios.")
    }
}
