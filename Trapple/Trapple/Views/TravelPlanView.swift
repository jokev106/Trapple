//
//  TravelPlanView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 26/08/22.
//

import SwiftUI
import CloudKit

struct TravelPlanView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var showCreatePlan = false
    @ObservedObject var vm: PlansViewModel
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                NavigationView {
                    VStack {
                        // Content
                        Divider
                        // Create and Join Button
                        CreateJoinButton
                        Divider
                        OnGoingTripSection
                    }.navigationTitle("Travel Plan")
                        .background(graybg)
                }
            }
        }
    }
}

//struct TravelPlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        TravelPlanView()
//    }
//}

// MARK: Components

extension TravelPlanView {
    private var Divider: some View {
        SwiftUI.Divider()
            .padding(.horizontal)
    }

    private var CreateJoinButton: some View {
        HStack {
            Spacer()

            Button {
                self.showCreatePlan.toggle()
            } label: {
                ZStack{
                    Rectangle()
                        .frame(width: 162, height: 72)
                        .foregroundColor(yellow)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
                    VStack{
                        Image(systemName: "rectangle.badge.plus")
                            .foregroundColor(blacktext)
                        Text("Create")
                            .foregroundColor(blacktext)
                            .font(Font.custom("Gilroy-ExtraBold", size: 16))
                    }
                }
                
            }.fullScreenCover(isPresented: $showCreatePlan, content: {
                CreatePlanView(vm: vm)
                    .navigationBarHidden(true)
            })

            Spacer()
                .frame(width: 15)
            Button {

            } label: {
                ZStack{
                    Rectangle()
                        .frame(width: 162, height: 72)
                        .foregroundColor(yellow)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
                    VStack{
                        Image(systemName: "person.3")
                            .foregroundColor(blacktext)
                        Text("Join")
                            .foregroundColor(blacktext)
                            .font(Font.custom("Gilroy-ExtraBold", size: 16))
                    }
                }
                
            }
            Spacer()

        }.padding()
    }

    private var OnGoingTripSection: some View {
        VStack {
            Text("On Going Trip").bold()
                .font(Font.custom("Gilroy-Light", size: 20))
                .frame(width: 370, alignment: .leading)
                .foregroundColor(Color.black)
                .padding(0.5)
            ScrollView{
                VStack{
                    ForEach(vm.plans, id: \.recordID) {items in
                        TripCardView(plan: items.title, destination: items.destination, startDate: items.startDate, endDate: items.endDate, planID: items.recordID!)
                            .onAppear{
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy MMMM d"
                                let dateString = dateFormatter.string(from: dateNow)
                                let currentDate = dateFormatter.date(from: dateString)
                                let startString = dateFormatter.string(from: items.startDate)
                                let startDateString = dateFormatter.date(from: startString)
                                if startDateString! < currentDate!{
                                    vm.updateHistory(plan: items)
                                }
                                vm.fetchItems()
                            }
                    }
                    .onAppear{
                        vm.fetchItems()
                    }
                }
            }
        }
    }
}

// MARK: Functions

extension TravelPlanView {}
