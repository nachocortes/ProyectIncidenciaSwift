//
//  AppIncidenciasApp.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import SwiftUI

@main
struct AppIncidenciasApp: App {
    @StateObject var authManager = AuthManager.shared
       
       var body: some Scene {
           WindowGroup {
               if authManager.isAuthenticated {
                   HomeView()
                       .environmentObject(authManager)
               } else {
                   LoginView()
                       .environmentObject(authManager)
               }
           }
       }

}
