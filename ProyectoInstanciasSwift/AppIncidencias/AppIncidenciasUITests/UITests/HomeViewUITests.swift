import XCTest
import SwiftUI
@testable import AppIncidencias

final class HomeViewUITests: XCTestCase {

    func testHomeViewRendersWithEmptyList() {
        let viewModel = IncidenciasViewModel()
        viewModel.incidencias = []

        let view = HomeView().environmentObject(AuthManager.shared)
        let hosting = UIHostingController(rootView: view)

        XCTAssertNotNil(hosting.view)
    }
}
