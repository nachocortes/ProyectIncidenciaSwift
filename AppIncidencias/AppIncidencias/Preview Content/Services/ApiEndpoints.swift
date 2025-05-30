//
//  ApiEndpoints2.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import Foundation

struct APIEndpoints {
    //static let baseURL = "http://127.0.0.1:8000/api"
    static let baseURL = "http://172.20.228.203:8000/api"

    struct Auth {
        static let login = "\(baseURL)/auth/login"
        static let logout = "\(baseURL)/auth/logout"
        static let me = "\(baseURL)/auth/me"
    }

    struct Incidencias {
        static func detalle(_ id: Int) -> String {
            "\(baseURL)/incidencias/\(id)"
        }

        static func estado(_ id: Int) -> String {
            "\(baseURL)/incidencias/\(id)/estado"
        }

        static func comentario(_ id: Int) -> String {
            "\(baseURL)/incidencias/\(id)/comentario"
        }

        static let latest = "\(baseURL)/incidencias/latest"
    }

    struct Users {
        static let total = "\(baseURL)/usersTotal"
        static func disable(_ id: Int) -> String {
            "\(baseURL)/users/\(id)/disable"
        }
    }

    struct Maquinas {
        static let list = "\(baseURL)/maquinas"
        static func update(_ id: Int) -> String {
            "\(baseURL)/maquinas/\(id)"
        }
    }

    struct Timer {
        static let base = "\(baseURL)/timer"
        static func detalle(_ id: Int) -> String {
            "\(baseURL)/timer/\(id)"
        }
        static func tiempoTotal(_ id: Int) -> String {
            "\(baseURL)/timer/\(id)/tiempototal"
        }
        static let latest = "\(baseURL)/timer/latest"
    }
}
