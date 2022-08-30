//
//  TrappleApp.swift
//  Trapple
//
//  Created by Vincent Leonard on 23/08/22.
//

import SwiftUI

@main
struct TrappleApp: App {
    @StateObject static var rulesViewModel = RulesViewModel()
    var body: some Scene {
        WindowGroup {
            RulesView( index: 1)
                .environmentObject(TrappleApp.rulesViewModel)
        }
    }
}
