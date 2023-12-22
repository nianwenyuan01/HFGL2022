//
//  HFGL2022App.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//

import SwiftUI

@main
struct HFGL2022App: App {
//    init(){
//        let locale = Locale(identifier: "zh-Hans-CN")
//        UserDefaults.standard.set(locale, forKey: "AppleLocale")
//        UserDefaults.standard.synchronize()
//    }
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
