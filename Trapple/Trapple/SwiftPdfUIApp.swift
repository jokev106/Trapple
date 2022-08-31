//
//  SwiftPdfUIApp.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 31/08/22.
//

import Foundation
import SwiftUI

@main struct SwiftUIPdfApp: App {
    
    var body: some Scene {
        WindowGroup {
            MenuView()
            .environmentObject(ContentViewModel())
            //ContentView()
            
        }
      
    }
}
