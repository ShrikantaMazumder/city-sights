//
//  CitySightsApp.swift
//  CitySights
//
//  Created by Shrikanta Mazumder on 24/8/21.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
