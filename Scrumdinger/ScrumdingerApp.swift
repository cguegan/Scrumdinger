//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Christophe Guégan on 15/12/2020.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.data)
        }
    }
}
