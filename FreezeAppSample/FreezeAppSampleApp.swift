//
//  FreezeAppSampleApp.swift
//  FreezeAppSample
//
//  Created by MuronakaHiroaki on 2023/11/18.
//

import SwiftUI

@main
struct FreezeAppSampleApp: App {
    @StateObject var model = ContentModel()
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 17.0, *) {
                NavigationStack {
                    ContentView()
                        .environmentObject(model)
                }
            }
        }
    }
}
