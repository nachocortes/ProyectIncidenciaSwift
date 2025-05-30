//
//  Comentario.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import Foundation
import SwiftUI

struct Comentario: Codable, Identifiable {
    let id: Int
    let comentario: String
    let created_at: String
    let usuario: Usuario?
}
