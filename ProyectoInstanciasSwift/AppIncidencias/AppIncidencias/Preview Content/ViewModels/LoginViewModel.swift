//
//  LoginViewModel.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import Foundation
import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var didLoginSuccessfully: Bool = false

    private var cancellables = Set<AnyCancellable>()

    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            self.errorMessage = "Correo y contraseña obligatorios."
            return
        }

        isLoading = true
        errorMessage = nil

        NetworkManager.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let authResponse):
                    guard authResponse.user.id_rol == Constants.Roles.tecnico else {
                        self?.errorMessage = "Acceso denegado: no eres un técnico."
                        return
                    }

                    KeychainHelper.saveToken(authResponse.accessToken)
                    UserDefaults.standard.set(authResponse.user.id, forKey: Constants.StorageKeys.tecnicoID)
                    UserDefaults.standard.set(authResponse.user.id_rol, forKey: Constants.StorageKeys.userRole)

                    AuthManager.shared.token = authResponse.accessToken
                    AuthManager.shared.tecnicoID = authResponse.user.id
                    AuthManager.shared.rol = authResponse.user.id_rol
                    self?.didLoginSuccessfully = true

                case .failure(let error):
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
