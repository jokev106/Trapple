//
//  TripHomePageView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 24/08/22.
//

import CloudKit
import SwiftUI

struct TripHomePageView: View {
    @StateObject private var vm = ActivitiesViewModel()
    @Binding var title: String
    @Binding var destination: String
    @Binding var planID: CKRecord.ID
    @Binding var startDate: Date
    @Binding var endDate: Date
    
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
        .onAppear {
            vm.fetchItem(planID: planID)
        }
        .navigationAppearance(backgroundColor: UIColor(graybg), foregroundColor: UIColor(blacktext), hideSeperator: true)
        .font(Font.custom("Gilroy-Light", size: 20))
        .navigationTitle(title)
//        }
//        .accentColor(.yellow)
//        .edgesIgnoringSafeArea(.top)
    }
}

// struct TripHomePageView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripHomePageView()
//    }
// }

// MARK: Components

extension TripHomePageView {
    private var Rundown: some View {
        VStack {
            NavigationLink(destination: RundownView(vm: vm, planID: $planID, startDate: $startDate, endDate: $endDate), label: {
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Rundown")
                            .font(Font.custom("Gilroy-ExtraBold", size: 20))
                        Text("\(destination)".uppercased())
                            .font(Font.custom("Gilroy-Light", size: 16))
                        Text("\(vm.getDateRange(startDate: startDate, endDate: endDate)) Days \(vm.getDateRange(startDate: startDate, endDate: endDate) - 1) Nights : \(startDate, format: Date.FormatStyle().day().month()) - \(endDate, format: Date.FormatStyle().day().month())")
                            .font(Font.custom("Gilroy-Light", size: 13))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("yellowCard"))
                    .cornerRadius(15)
                    
//                    RundownCardview(activity: vm.activity[0].title, location: vm.activity[0].location, startTime: vm.activity[0].startDate)
//                        .padding()
                }
            })
        }
        .foregroundColor(.black)
        .background(.white)
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
    }
    
    private var Equipment: some View {
        VStack {
            ZStack(alignment: .top) {
                HStack(spacing: 0) {
                    NavigationLink(destination: CategoryView(planID: planID, title: "Food & Beverages", image: "fork.knife"), label: {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("grayBG"))
                    
                            Image(systemName: "fork.knife")
                        }
                    })
                
                    Spacer()
                
                    NavigationLink(destination: CategoryView(planID: planID, title: "Apparel", image: "tshirt"), label: {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("grayBG"))
                    
                            Image(systemName: "tshirt")
                        }
                    })
                
                    Spacer()
                
                    NavigationLink(destination: CategoryView(planID: planID, title: "Tools", image: "wrench"), label: {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("grayBG"))
                    
                            Image(systemName: "wrench")
                        }
                    })
                
                    Spacer()
                
                    NavigationLink(destination: CategoryView(planID: planID, title: "Medicine", image: "pills"), label: {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("grayBG"))
                    
                            Image(systemName: "pills")
                        }
                    })
                
                    Spacer()
                
                    NavigationLink(destination: CategoryView(planID: planID, title: "Folder", image: "folder"), label: {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("grayBG"))
                    
                            Image(systemName: "folder")
                        }
                    })
                }
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
                .padding(12)
                .padding(.top, 55)
                .background(.white)
                
                NavigationLink(destination: EquipmentView(planID: planID), label: {
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
                    }
                })
            }
        }
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
    }
    
    private var Rules: some View {
        VStack {
            NavigationLink(destination: RulesView(),
                           //                .environmentObject(TripHomePageView.rulesViewModel)
                           label: {
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
        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
    }
}
