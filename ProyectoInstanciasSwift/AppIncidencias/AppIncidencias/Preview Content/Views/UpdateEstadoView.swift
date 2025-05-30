//
//  UpdateEstadoView.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import SwiftUI

struct UpdateEstadoView: View {
    let incidenciaID: Int
    @Binding var estado: Int

    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Estado actual:")
                .font(.headline)

            Text(Constants.IncidenciaEstado.descripcion(estado: estado))
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button(action: {
                toggleEstado()
            }) {
                Text("Cambiar a \(Constants.IncidenciaEstado.descripcion(estado: estado == 0 ? 1 : 0))")
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading)

            if isLoading {
                ProgressView()
            }

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .padding(.top)
    }

    private func toggleEstado() {
        let nuevo = (estado == 0) ? 1 : 0
        isLoading = true
        errorMessage = nil

        NetworkManager.updateEstado(id: incidenciaID, estado: nuevo) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    self.estado = nuevo
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
