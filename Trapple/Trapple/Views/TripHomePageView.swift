//
//  TripHomePageView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 24/08/22.
//

import CloudKit
import SwiftUI

struct TripHomePageView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var planVM = PlansViewModel()
    @Binding var planRecord: PlanViewModel
    @StateObject private var vmActivity = ActivitiesViewModel()
    @StateObject private var vmRules = RulesViewModel()
    @Binding var title: String
    @Binding var destination: String
    @Binding var planID: CKRecord.ID
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var categoryDefault: Int64
    
    @State var iconCount: Int = 0
    @StateObject var categoryViewModel = CategoriesViewModel()
    
    var body: some View {
//        NavigationView {
        ScrollView {
            VStack {
                Spacer()
                Rundown
                Equipment
                Rules
            }
//                .background(graybg)
        }
        .background(graybg)
        .onAppear {
//            vmActivity.fetchItem(planID: planID)
            
            if categoryDefault == 0 {
                categoryViewModel.addButtonPressed(planID: planID, category: "Food & Beverages", icon: "fork.knife")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    categoryViewModel.addButtonPressed(planID: planID, category: "Apparel", icon: "tshirt")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    categoryViewModel.addButtonPressed(planID: planID, category: "Tools", icon: "wrench")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    categoryViewModel.addButtonPressed(planID: planID, category: "Medicine", icon: "pills")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    categoryViewModel.addButtonPressed(planID: planID, category: "Folder", icon: "folder")
                }
                planVM.updateCategory(plan: planRecord)
                categoryDefault = 1
            }
            
            categoryViewModel.fetchItems(planID: planID)
        }
        .font(Font.custom("Gilroy-Light", size: 20))
        .navigationTitle(title)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    // Back to Travel Plan Screen
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(deepblue)
//                    Text("Travel Plan")
//                        .foregroundColor(deepblue)
//                }
//            }
//        }
    }
//        .edgesIgnoringSafeArea(.top)
//    }
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
            NavigationLink(destination: RundownView(vm: vmActivity, planID: $planID, startDate: $startDate, endDate: $endDate), label: {
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Rundown")
                            .font(Font.custom("Gilroy-ExtraBold", size: 20))
                            .foregroundColor(deepblue)
                        Text("\(destination)".uppercased())
                            .font(Font.custom("Gilroy-Light", size: 16))
                            .foregroundColor(deepblue)
                        Text("\(vmActivity.getDateRange(startDate: startDate, endDate: endDate)) Days \(vmActivity.getDateRange(startDate: startDate, endDate: endDate) - 1) Nights : \(startDate, format: Date.FormatStyle().day().month()) - \(endDate, format: Date.FormatStyle().day().month())")
                            .font(Font.custom("Gilroy-Light", size: 13))
                            .foregroundColor(deepblue)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(lightpurple)
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
        .onAppear {
            vmActivity.fetchItems(planID: planID)
        }
    }
    
    private var Equipment: some View {
        VStack {
            ZStack(alignment: .top) {
                HStack(spacing: 0) {
//                    NavigationLink(destination: CategoryView(planID: planID, title: "Food & Beverages", image: "fork.knife"), label: {
//                        ZStack {
//                            Circle()
//                                .frame(width: 50, height: 50)
//                                .foregroundColor(Color("grayBG"))
//
//                            Image(systemName: "fork.knife")
//                        }
//                    })
//
//                    Spacer()
//
//                    NavigationLink(destination: CategoryView(planID: planID, title: "Apparel", image: "tshirt"), label: {
//                        ZStack {
//                            Circle()
//                                .frame(width: 50, height: 50)
//                                .foregroundColor(Color("grayBG"))
//
//                            Image(systemName: "tshirt")
//                        }
//                    })
//
//                    Spacer()
//
//                    NavigationLink(destination: CategoryView(planID: planID, title: "Tools", image: "wrench"), label: {
//                        ZStack {
//                            Circle()
//                                .frame(width: 50, height: 50)
//                                .foregroundColor(Color("grayBG"))
//
//                            Image(systemName: "wrench")
//                        }
//                    })
//
//                    Spacer()
//
//                    NavigationLink(destination: CategoryView(planID: planID, title: "Medicine", image: "pills"), label: {
//                        ZStack {
//                            Circle()
//                                .frame(width: 50, height: 50)
//                                .foregroundColor(Color("grayBG"))
//
//                            Image(systemName: "pills")
//                        }
//                    })
//
//                    Spacer()
//
//                    NavigationLink(destination: CategoryView(planID: planID, title: "Folder", image: "folder"), label: {
//                        ZStack {
//                            Circle()
//                                .frame(width: 50, height: 50)
//                                .foregroundColor(Color("grayBG"))
//
//                            Image(systemName: "folder")
//                        }
//                    })
                    ForEach(categoryViewModel.categoryVM.indices.prefix(5), id: \.self) { item in
                        NavigationLink(destination: CategoryView(categoryID: categoryViewModel.categoryVM[item].recordID!, title: categoryViewModel.categoryVM[item].category, image: categoryViewModel.categoryVM[item].icon), label: {
                            ZStack {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color("grayBG"))
    
                                Image(systemName: categoryViewModel.categoryVM[item].icon)
                            }
                        })
                        if item < 4 {
                            Spacer()
                        }
                    }
                }
                .foregroundColor(deepblue)
                .frame(maxWidth: .infinity)
                .padding(12)
                .padding(.top, 55)
                .background(lilac)
                
                NavigationLink(destination: EquipmentView(vm: categoryViewModel, planID: planID), label: {
                    VStack(spacing: 0) {
                        VStack(alignment: .leading) {
                            Text("Equipment")
                                .font(Font.custom("Gilroy-ExtraBold", size: 20))
                                .foregroundColor(deepblue)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(lightpurple)
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
            NavigationLink(destination: RulesView(planID: planID), label: {
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Rules")
                            .font(Font.custom("Gilroy-ExtraBold", size: 20))
                            .foregroundColor(deepblue)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(lightpurple)
                    .cornerRadius(15)
                    
                    ForEach(vmRules.rules.indices, id: \.self) { index in
                        if index == 0 {
                            HStack(spacing: 0) {
                                Rectangle()
                                    .frame(width: 5)
                                    .background(deepblue)
                                    .cornerRadius(15)
                                    .padding(.trailing)
                                    .opacity(0.4)
                        
                                VStack(alignment: .leading) {
                                    Text("\(vmRules.rules[index].title)")
                                        .font(Font.custom("Gilroy-ExtraBold", size: 20))
                                    Text("\(vmRules.rules[index].description)")
                                        .font(Font.custom("Gilroy-Light", size: 15))
                                }
                        
                                .frame(maxWidth: 200, alignment: .leading)
                            }
                        }
                    }
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                
            })
        }
        .foregroundColor(blacktext)
        .background(tripcardColor)
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
        .onAppear {
            vmRules.fetchItems(planID: planID)
        }
    }
}
