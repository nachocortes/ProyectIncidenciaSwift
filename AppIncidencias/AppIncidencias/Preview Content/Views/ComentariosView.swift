//
//  ComentariosView.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import SwiftUI

struct ComentariosView: View {
    let incidenciaID: Int
    @Binding var comentarios: [Comentario]

    @State private var nuevoComentario: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Comentarios")
                .font(.headline)

            if comentarios.isEmpty {
                Text("Sin comentarios.")
                    .foregroundColor(.gray)
            } else {
                ForEach(comentarios, id: \.id) { comentario in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(comentario.comentario)
                            .font(.body)
                        if let usuario = comentario.usuario {
                            Text("por \(usuario.name)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }

            Divider()

            HStack {
                TextField("Escribe un comentario...", text: $nuevoComentario)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Enviar") {
                    enviarComentario()
                }
                .disabled(nuevoComentario.isEmpty)
            }

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

    private func enviarComentario() {
        isLoading = true
        errorMessage = nil

        NetworkManager.addComentario(id: incidenciaID, texto: nuevoComentario) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success:
                    nuevoComentario = ""
                    NetworkManager.getComentarios(id: incidenciaID) { fetchResult in
                        DispatchQueue.main.async {
                            switch fetchResult {
                            case .success(let nuevos):
                                self.comentarios = nuevos
                            case .failure(let error):
                                self.errorMessage = error.localizedDescription
                            }
                        }
                    }
                case .failure(let error):
                    errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
