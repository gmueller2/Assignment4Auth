//
//  HealthInspectionappApp.swift
//  HealthInspectionapp
//
//  Created by Gene Mueller on 11/5/23.
//

import SwiftUI
import Firebase

@main
struct HealthInspectionappApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
