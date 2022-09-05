//
//  NavigationAppearance.swift
//  Trapple
//
//  Created by Jonathan Kevin on 28/08/22.
//

import Foundation
import SwiftUI

struct NavAppearanceModifier: ViewModifier{
    
    init(backgroundColor: UIColor, foregroundColor: UIColor, hideSeperator: Bool){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = backgroundColor
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [ .font : UIFont(name: "Gilroy-ExtraBold", size: 30),
            NSAttributedString.Key.foregroundColor : foregroundColor]
        if hideSeperator {
            navBarAppearance.shadowColor = .clear
        }
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationAppearance(backgroundColor: UIColor, foregroundColor: UIColor, hideSeperator: Bool = false) -> some View {
        self.modifier(NavAppearanceModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, hideSeperator: hideSeperator))
    }
}
