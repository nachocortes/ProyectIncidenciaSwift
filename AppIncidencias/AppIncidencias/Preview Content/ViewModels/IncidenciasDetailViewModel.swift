//
//  IncidenciasDetailViewModel.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//
import SwiftUI

class IncidenciaDetailViewModel: ObservableObject {
    @Published var comentarios: [Comentario] = []
    @Published var estado: Int = 0
    @Published var errorMessage: String?

    func load(for incidenciaID: Int) {
        getEstado(incidenciaID)
        getComentarios(incidenciaID)
    }

    func getEstado(_ id: Int) {
        NetworkManager.getIncidenciaEstado(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let estadoActual):
                    self.estado = estadoActual
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func getComentarios(_ id: Int) {
        NetworkManager.getComentarios(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comentarios):
                    self.comentarios = comentarios
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func addComentario(to id: Int, texto: String) {
        NetworkManager.addComentario(id: id, texto: texto) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.getComentarios(id)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func toggleEstado(for id: Int) {
        let nuevoEstado = (estado == 0) ? 1 : 0
        NetworkManager.updateEstado(id: id, estado: nuevoEstado) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.estado = nuevoEstado
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
