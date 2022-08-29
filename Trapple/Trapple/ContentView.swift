//
//  ContentView.swift
//  Trapple
//
//  Created by Vincent Leonard on 23/08/22.
//

import SwiftUI

struct ContentView: View {
    init() {
        let navigationBarAppearace = UINavigationBarAppearance()
        
        navigationBarAppearace.configureWithOpaqueBackground()
        
        navigationBarAppearace.backgroundColor = UIColor(Color("navBG"))
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearace
        
        UINavigationBar.appearance().compactAppearance = navigationBarAppearace
        
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearace
    }
    
    var body: some View {
        TripHomePageView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
