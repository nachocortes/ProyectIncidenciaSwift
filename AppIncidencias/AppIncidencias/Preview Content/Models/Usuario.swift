//
//  Usuario2.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import Foundation

struct Usuario: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String?
    let email: String
    let id_rol: Int
}
