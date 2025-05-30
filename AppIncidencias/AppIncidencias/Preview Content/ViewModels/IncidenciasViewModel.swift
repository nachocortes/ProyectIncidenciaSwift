//
//  IncidenciasViewModel.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//
import SwiftUI

class IncidenciasViewModel: ObservableObject {
    @Published var incidencias: [Incidencia] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchIncidencias(for tecnicoID: Int) {
        isLoading = true
        errorMessage = nil

        NetworkManager.getIncidencias { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let allIncidencias):
                    self?.incidencias = allIncidencias.filter { $0.id_usuario == tecnicoID }
                case .failure(let error):
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
