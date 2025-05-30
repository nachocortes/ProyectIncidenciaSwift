import Foundation
@testable import AppIncidencias

class NetworkManagerMock {
    static var authResponse: Result<AuthResponse, Error>?
    static var comentariosResponse: Result<[Comentario], Error>?
    static var estadoResponse: Result<Int, Error>?

    static var updateEstadoHandler: ((Int, Int, @escaping (Result<Void, Error>) -> Void) -> Void)?
    static var addComentarioHandler: ((Int, String, @escaping (Result<Void, Error>) -> Void) -> Void)?

    static func login(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        if let result = authResponse {
            completion(result)
        }
    }

    static func getComentarios(id: Int, completion: @escaping (Result<[Comentario], Error>) -> Void) {
        if let result = comentariosResponse {
            completion(result)
        }
    }

    static func getIncidenciaEstado(id: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        if let result = estadoResponse {
            completion(result)
        }
    }

    static func updateEstado(id: Int, estado: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        updateEstadoHandler?(id, estado, completion)
    }

    static func addComentario(id: Int, texto: String, completion: @escaping (Result<Void, Error>) -> Void) {
        addComentarioHandler?(id, texto, completion)
    }
}
