//
//  Special_ParakeetApp.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 15/11/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct Special_ParakeetApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.firebaseDatabase, Firestore.firestore())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
    FirebaseApp.configure()
      
    return true
  }
}

private struct FirebaseDatabase: EnvironmentKey {
    static var defaultValue: Firestore = Firestore.firestore()
}

extension EnvironmentValues {
    var firebaseDatabase: Firestore {
        get {
            FirebaseDatabase.defaultValue.self
        }
        set(newFirestoreInstance) {
            self[FirebaseDatabase.self] = newFirestoreInstance
        }
    }
}
