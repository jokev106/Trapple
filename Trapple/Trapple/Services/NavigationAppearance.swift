//
//  NavigationAppearance.swift
//  Trapple
//
//  Created by Jonathan Kevin on 28/08/22.
//

import Foundation
import SwiftUI

struct NavAppearanceModifier: ViewModifier{
    
    init(backgroundColor: UIColor, foregroundColor: UIColor, hideSeperator: Bool, tabbarColor: UIColor){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = backgroundColor
        navBarAppearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        if hideSeperator {
            navBarAppearance.shadowColor = .clear
        }
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(darkblue)
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UITabBar.appearance().barTintColor = tabbarColor
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationAppearance(backgroundColor: UIColor, foregroundColor: UIColor, hideSeperator: Bool = false) -> some View {
        self.modifier(NavAppearanceModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, hideSeperator: hideSeperator, tabbarColor: UIColor(darkblue)))
    }
}
