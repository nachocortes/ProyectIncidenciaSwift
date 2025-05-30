//
//  Incidencia2.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import Foundation

struct Incidencia: Codable, Identifiable {
    let id: Int
    let titulo: String
    let descripcion: String
    let categoria: Int
    let maquina: Int
    let estado: Int
    let id_usuario: Int
}
