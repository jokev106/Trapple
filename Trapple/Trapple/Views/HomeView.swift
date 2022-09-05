//
//  HomeView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 24/08/22.
//

import SwiftUI
import CloudKit

struct HomeView: View {
    
    @StateObject private var CKvm = CloudKitViewModel()
    @StateObject private var vm = PlansViewModel()
    
    init() {
        
//        UITabBar.appearance().barTintColor = UIColor(darkblue)
        
        let tabBarAppearance = UITabBarAppearance()

        tabBarAppearance.backgroundColor = UIColor(darkblue)

        UITabBar.appearance().standardAppearance = tabBarAppearance

        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let toolBarAppearance = UIToolbarAppearance()
        
//        UIToolbar.appearance().barTintColor = UIColor.red
        
        toolBarAppearance.backgroundColor = UIColor(darkblue)
        
        UIToolbar.appearance().standardAppearance = toolBarAppearance
        
        let toolBarAppearance2 = UIToolbarAppearance()
        
        toolBarAppearance2.backgroundColor = UIColor(graybg)

        UIToolbar.appearance().scrollEdgeAppearance = toolBarAppearance2
        
    }

    var body: some View {
        GeometryReader { _ in
            ZStack {
                NavigationView {
                    TabView {
                        // Move to Travel Plan view
                        TravelPlanView(vm: vm)
                            .tabItem {
                                Label("Travel Plan", systemImage: "airplane")
                            }

                        // Move to my profile view
                        MyProfileView()
                            .tabItem {
                                Label("My Profile", systemImage: "person.crop.circle.fill")
                            }
                    }
//                    .navigationBarHidden(true)
                }
                .accentColor(yellow)
            }
        }
    }
}
