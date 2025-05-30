//
//  LoginView.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("AppIncidencias - Técnicos")
                    .font(.title)
                    .bold()

                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Contraseña", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Button("Iniciar sesión") {
                        viewModel.login()
                    }
                    .buttonStyle(.borderedProminent)
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
            .onReceive(viewModel.$didLoginSuccessfully) { success in
                if success {
                    authManager.token = KeychainHelper.loadToken()
                    authManager.tecnicoID = UserDefaults.standard.integer(forKey: Constants.StorageKeys.tecnicoID)
                    authManager.rol = UserDefaults.standard.integer(forKey: Constants.StorageKeys.userRole)
                }
            }
        }
    }
}
