//
//  HomeView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 24/08/22.
//

import SwiftUI

struct HomeView: View {
    
    init(){
        UITabBar.appearance().barTintColor = UIColor(darkblue)
    }
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                TabView {
                    
                    //Move to Travel Plan view
                    TravelPlanView()
                        .tabItem{
                            Label("Travel Plan", systemImage: "airplane")
                        }
                    
                    //Move to my profile view
                    MyProfileView()
                        .tabItem{
                            Label("My Profile", systemImage: "person.crop.circle.fill")
                        }
                }.accentColor(yellow)
                
            }
        }
    }
}
