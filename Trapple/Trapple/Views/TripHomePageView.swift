//
//  TripHomePageView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 24/08/22.
//

import SwiftUI
import CloudKit

struct TripHomePageView: View {
    
    @StateObject private var vm = ActivitiesViewModel()
    @State var title: String = ""
    @State var planID = CKRecord.ID()
    
    init(){
        UITabBar.appearance().barTintColor = UIColor(darkblue)
    }
    
    @StateObject static var rulesViewModel = RulesViewModel()
    
    var body: some View {
//        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                    Rundown
                    Equipment
                    Rules
                }
            }
            .navigationAppearance(backgroundColor: UIColor(graybg), foregroundColor: UIColor(blacktext), hideSeperator: true)
            .background(Color("grayBG"))
            .font(Font.custom("Gilroy-Light", size: 20))
            .navigationBarTitle(Text("Trip Name"), displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.black)
                    })
                }
            }
//        }
//        .accentColor(.yellow)
//        .edgesIgnoringSafeArea(.top)
    }
}

struct TripHomePageView_Previews: PreviewProvider {
    static var previews: some View {
        TripHomePageView()
    }
}

// MARK: Components

extension TripHomePageView {
    private var Rundown: some View {
        VStack {
            NavigationLink(destination: RundownView(), label: {
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Rundown")
                            .font(Font.custom("Gilroy-ExtraBold", size: 20))
                        Text("Description".uppercased())
                            .font(Font.custom("Gilroy-Light", size: 16))
                        Text("Days : From - Until")
                            .font(Font.custom("Gilroy-Light", size: 13))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("yellowCard"))
                    .cornerRadius(15)
                    
                    RundownCardview()
                        .padding()
                }
            })
        }
        .foregroundColor(.black)
        .background(.white)
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    private var Equipment: some View {
        VStack {
            NavigationLink(destination: EquipmentView(), label: {
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Equipment")
                            .font(Font.custom("Gilroy-ExtraBold", size: 20))
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("yellowCard"))
                    .cornerRadius(15)
                    
                    HStack(spacing: 0) {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("grayBG"))
                            
                            Image(systemName: "fork.knife")
                        }
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("grayBG"))
                            
                            Image(systemName: "tshirt")
                        }
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("grayBG"))
                            
                            Image(systemName: "wrench")
                        }
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("grayBG"))
                            
                            Image(systemName: "pills")
                        }
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("grayBG"))
                            
                            Image(systemName: "folder")
                        }
                    }
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            })
        }
        .background(.white)
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    private var Rules: some View {
       
        VStack {
            
            NavigationLink(destination: RulesView(index: 1)
                .environmentObject(TripHomePageView.rulesViewModel)
                           , label: {
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Rules")
                            .font(Font.custom("Gilroy-ExtraBold", size: 20))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("yellowCard"))
                    .cornerRadius(15)
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 5)
                            .background(.black)
                            .cornerRadius(15)
                            .padding(.trailing)
                            .opacity(0.4)
                        
                        VStack(alignment: .leading) {
                            Text("Rules Number One")
                                .font(Font.custom("Gilroy-ExtraBold", size: 20))
                            Text("Short Desc")
                                .font(Font.custom("Gilroy-Light", size: 15))
                        }
                        
                        .frame(maxWidth: 200, alignment: .leading)
                    }
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                
            })
        }
        .foregroundColor(.black)
        .background(.white)
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}
