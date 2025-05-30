//
//  NetworkManager2.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import Foundation
import SwiftUI

class NetworkManager {

    static func login(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.Auth.login) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body: [String: String] = [
            "email": email,
            "password": password
        ]

        do {
            request.httpBody = try JSONEncoder().encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            completion(.failure(NetworkError.encodingFailed))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }

        }.resume()
    }

    static func getIncidencias(completion: @escaping (Result<[Incidencia], Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.Incidencias.latest) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        if let token = KeychainHelper.loadToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoded = try JSONDecoder().decode([Incidencia].self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
        }.resume()
    }

    static func getIncidenciaEstado(id: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.Incidencias.estado(id)) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        if let token = KeychainHelper.loadToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let estado = try JSONDecoder().decode(Int.self, from: data)
                completion(.success(estado))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
        }.resume()
    }

    static func getComentarios(id: Int, completion: @escaping (Result<[Comentario], Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.Incidencias.comentario(id)) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        if let token = KeychainHelper.loadToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoded = try JSONDecoder().decode([Comentario].self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
        }.resume()
    }

    static func addComentario(id: Int, texto: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.Incidencias.comentario(id)) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = KeychainHelper.loadToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let body = ["comentario": texto]
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(NetworkError.encodingFailed))
            return
        }

        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }.resume()
    }

    static func updateEstado(id: Int, estado: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.Incidencias.estado(id)) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = KeychainHelper.loadToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let body = ["estado": estado]
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(NetworkError.encodingFailed))
            return
        }

        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }.resume()
    }

    static func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.Auth.logout) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        if let token = KeychainHelper.loadToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            completion(.failure(NetworkError.unauthorized))
            return
        }

        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }.resume()
    }

    enum NetworkError: Error {
        case invalidURL
        case encodingFailed
        case invalidResponse
        case noData
        case decodingFailed
        case unauthorized
    }
}
