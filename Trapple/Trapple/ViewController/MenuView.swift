//
//  MenuView.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 31/08/22.
//

import Foundation
import SwiftUI

struct MenuView : View {
    
    
    var body : some View {
        
        NavigationView {
            
            List {
                
                NavigationLink( destination: ContentViews()){
                    
                    Text ("1. A PDF Creator app, insert title and desc.")
                }
            
                NavigationLink( destination: ViewControllerSwiftUIView().navigationTitle(Text("Example 1")) ){
                    
                    Text ("2. Example of a created PDF, ready to be shared(?)")
                }
                
               
            }
            .navigationTitle(Text("Menu"))
           
        }
        .navigationViewStyle(StackNavigationViewStyle())
      
        
    }
}
