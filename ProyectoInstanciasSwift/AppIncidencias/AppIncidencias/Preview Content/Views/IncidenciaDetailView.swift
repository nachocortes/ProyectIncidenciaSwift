//
//  IncidenciaDetailView.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import SwiftUI

struct IncidenciaDetailView: View {
    let incidencia: Incidencia
    @StateObject private var viewModel = IncidenciaDetailViewModel()
    @EnvironmentObject var authManager: AuthManager
    
    @State private var nuevoComentario: String = ""
    @State private var showError = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Título:")
                    .font(.headline)
                Text(incidencia.titulo)
                
                Text("Descripción:")
                    .font(.headline)
                Text(incidencia.descripcion)
                
                Text("Estado actual: \(viewModel.estado)")
                    .font(.subheadline)
                
                Button("Cambiar estado") {
                    viewModel.toggleEstado(for: incidencia.id)
                }
                .buttonStyle(.borderedProminent)
                
                Divider()
                
                Text("Comentarios")
                    .font(.headline)
                
                if viewModel.comentarios.isEmpty {
                    Text("Sin comentarios.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(viewModel.comentarios, id: \.id) { comentario in
                        VStack(alignment: .leading) {
                            Text(comentario.comentario)
                                .font(.body)
                            if let user = comentario.usuario {
                                Text("por \(user.name)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }

                HStack {
                    TextField("Nuevo comentario", text: $nuevoComentario)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Enviar") {
                        viewModel.addComentario(to: incidencia.id, texto: nuevoComentario)
                        nuevoComentario = ""
                    }
                    .disabled(nuevoComentario.isEmpty)
                }
            }
            .padding()
        }
        .navigationTitle("Detalle")
        .onAppear {
            viewModel.load(for: incidencia.id)
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Error desconocido"), dismissButton: .default(Text("OK")))
        }
    }
}
