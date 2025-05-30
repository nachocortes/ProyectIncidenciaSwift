import Foundation
@testable import AppIncidencias

struct TestUtilities {
    static func mockUsuario(id: Int = 1, rol: Int = Constants.Roles.tecnico) -> Usuario {
        return Usuario(id: id, name: "Test User", username: "tester", email: "test@example.com", id_rol: rol)
    }

    static func mockAuthResponse(token: String = "mock_token", user: Usuario? = nil) -> AuthResponse {
        return AuthResponse(accessToken: token, user: user ?? mockUsuario())
    }

    static func mockComentario(id: Int = 1, text: String = "Comentario de prueba") -> Comentario {
        return Comentario(id: id, comentario: text, created_at: "2025-01-01T00:00:00Z", usuario: mockUsuario())
    }

    static func mockIncidencia(id: Int = 1, estado: Int = 0, tecnicoID: Int = 1) -> Incidencia {
        return Incidencia(id: id, titulo: "Incidencia Test", descripcion: "Descripción de prueba", categoria: 1, maquina: 1, estado: estado, id_usuario: tecnicoID)
    }
}
