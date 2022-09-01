//
//  MenuView.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 01/09/22.
//

import Foundation
import SwiftUI

struct MenuView : View {
    
    
    var body : some View {
        
        NavigationView {
            
            List {
                
                NavigationLink( destination: ContentViews()){
                    
                    Text ("1. PDF File Creator(?)")
                }
            
                NavigationLink( destination: ViewControllerSwiftUIView().navigationTitle(Text("Example 1")) ){
                    
                    Text ("2. Example of a shareable PDF File")
                }
                
                
               
            }
            .navigationTitle(Text("Menu"))
           
        }
        .navigationViewStyle(StackNavigationViewStyle())
      
        
    }
}
