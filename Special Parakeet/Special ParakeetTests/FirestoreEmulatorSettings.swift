//
//  FirestoreEmulatorSettings.swift
//  Special ParakeetTests
//
//  Created by Asaad Jaber on 26/01/2024.
//

import Foundation
import FirebaseFirestore

struct FirestoreEmulatorSettings {
    var settings: FirestoreSettings {
        makeSettings()
    }
    
    func makeSettings() -> FirestoreSettings {
        let settings = Firestore.firestore().settings
        settings.host = "127.0.0.1:8080"
        settings.cacheSettings = MemoryCacheSettings()
        settings.isSSLEnabled = false
        return settings
    }
}
