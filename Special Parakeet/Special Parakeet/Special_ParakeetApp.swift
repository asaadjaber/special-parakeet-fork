//
//  Special_ParakeetApp.swift
//  Special Parakeet
//
//  Created by Asaad Jaber on 15/11/2023.
//

import SwiftUI
import FirebaseCore

@main
struct Special_ParakeetApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
    FirebaseApp.configure()
      
    return true
  }
}

