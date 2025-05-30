//
//  AuthManager.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import SwiftUI

class AuthManager: ObservableObject {
    static let shared = AuthManager()

    @Published var token: String?
    @Published var tecnicoID: Int?
    @Published var rol: Int?

    var isAuthenticated: Bool {
        token != nil && rol == Constants.Roles.tecnico
    }

    private init() {
        self.token = KeychainHelper.loadToken()
        let defaults = UserDefaults.standard

        let storedID = defaults.integer(forKey: Constants.StorageKeys.tecnicoID)
        self.tecnicoID = storedID == 0 ? nil : storedID

        let storedRol = defaults.integer(forKey: Constants.StorageKeys.userRole)
        self.rol = storedRol == 0 ? nil : storedRol

        if token == nil || rol != Constants.Roles.tecnico {
            logout()
        }
    }

    func logout() {
        NetworkManager.logout { _ in
            DispatchQueue.main.async {
                self.token = nil
                self.tecnicoID = nil
                self.rol = nil

                KeychainHelper.deleteToken()
                let defaults = UserDefaults.standard
                defaults.removeObject(forKey: Constants.StorageKeys.tecnicoID)
                defaults.removeObject(forKey: Constants.StorageKeys.userRole)
            }
        }
    }
}
