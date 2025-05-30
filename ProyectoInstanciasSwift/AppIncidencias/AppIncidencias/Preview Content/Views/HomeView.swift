//
//  HomeView.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject private var viewModel = IncidenciasViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Cargando incidencias...")
                } else if viewModel.incidencias.isEmpty {
                    Text("No tienes incidencias asignadas.")
                        .foregroundColor(.gray)
                } else {
                    List(viewModel.incidencias) { incidencia in
                        NavigationLink(destination: IncidenciaDetailView(incidencia: incidencia)) {
                            VStack(alignment: .leading) {
                                Text(incidencia.titulo)
                                    .font(.headline)
                                Text("Estado: \(incidencia.estado)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }

                Button("Cerrar sesión") {
                    authManager.logout()
                }
                .padding(.top)
                .buttonStyle(.bordered)
            }
            .navigationTitle("Mis Incidencias")
            .onAppear {
                if let tecnicoID = authManager.tecnicoID {
                    viewModel.fetchIncidencias(for: tecnicoID)
                }
            }
        }
    }
}
