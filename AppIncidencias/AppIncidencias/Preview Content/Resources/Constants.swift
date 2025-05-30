//
//  Constants.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import Foundation

struct Constants {

    // MARK: - API
    static let baseAPIURL = "http://172.20.228.203:8000/api"

    // MARK: - Roles
    struct Roles {
        static let tecnico = 1
        static let administrador = 2
        static let supervisor = 3
    }

    // MARK: - Estados de incidencia
    struct IncidenciaEstado {
        static let pendiente = 0
        static let resuelta = 1

        static func descripcion(estado: Int) -> String {
            switch estado {
            case pendiente: return "Pendiente"
            case resuelta: return "Resuelta"
            default: return "Desconocido"
            }
        }
    }

    // MARK: - Claves de almacenamiento
    struct StorageKeys {
        static let token = "authToken"
        static let tecnicoID = "tecnicoID"
        static let userRole = "userRole"
    }
}
