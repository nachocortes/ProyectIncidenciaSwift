import XCTest
@testable import AppIncidencias

final class IncidenciaDetailViewModelTests: XCTestCase {

    func testInitialEstadoLoad() {
        let viewModel = IncidenciaDetailViewModel()
        viewModel.estado = 0

        NetworkManagerMock.estadoResponse = .success(1)
        viewModel.getEstado(1)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(viewModel.estado, 1)
        }
    }

    func testAddComentarioUpdatesList() {
        let viewModel = IncidenciaDetailViewModel()
        let mockComentario = Comentario(id: 1, comentario: "Test", created_at: "", usuario: nil)

        NetworkManagerMock.addComentarioHandler = { _, _, completion in
            completion(.success(()))
        }

        NetworkManagerMock.comentariosResponse = .success([mockComentario])
        viewModel.addComentario(to: 1, texto: "Nuevo comentario")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(viewModel.comentarios.count, 1)
            XCTAssertEqual(viewModel.comentarios.first?.comentario, "Test")
        }
    }
}
