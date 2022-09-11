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
        
        //Initialize TabBar
//        let tabBarAppearance = UITabBarAppearance()
//
//        tabBarAppearance.backgroundColor = UIColor(lightpurple)
        UITabBar.appearance().backgroundColor = UIColor(lightpurple)
//        UITabBar.appearance().barTintColor = UIColor(deepblue)
        UITabBar.appearance().unselectedItemTintColor = UIColor(lilac)
//        UITabBar.appearance().barTintColor = UIColor(lightpurple)
        
//        UITabBar.appearance().standardAppearance = tabBarAppearance
//
//        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        //Initialize Toolbar
        let toolBarAppearance = UIToolbarAppearance()
        
        toolBarAppearance.backgroundColor = UIColor(lightpurple)
        
        UIToolbar.appearance().standardAppearance = toolBarAppearance
        
        let toolBarAppearance2 = UIToolbarAppearance()
        
        toolBarAppearance2.backgroundColor = UIColor(graybg)

        UIToolbar.appearance().scrollEdgeAppearance = toolBarAppearance2
        
        //Initialize NavBar
        let navigationBarAppearace = UINavigationBarAppearance()

        navigationBarAppearace.backgroundColor = UIColor(graybg)

        navigationBarAppearace.largeTitleTextAttributes = [
            .font : UIFont(name: "Gilroy-ExtraBold", size: 30),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        
        navigationBarAppearace.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = navigationBarAppearace
        
        UINavigationBar.appearance().compactAppearance = navigationBarAppearace

        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearace

    }

    var body: some View {
        GeometryReader { _ in
            ZStack {
                NavigationView {
                    TabView {
                        // Move to Travel Plan view
                        TravelPlanView(vm: vm)
                            .navigationBarHidden(true)
                            .tabItem {
                                Label("Travel Plan", systemImage: "airplane")
                            }

                        // Move to my profile view
                        MyProfileView()
                            .navigationBarHidden(true)
                            .tabItem {
                                Label("My Profile", systemImage: "person.crop.circle.fill")
                            }
                    }
                }
                .accentColor(deepblue)
            
            }
        }
    }
}
