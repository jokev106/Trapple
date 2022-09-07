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
    @StateObject private var vm = PlansViewModel()
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                NavigationView {
                    VStack {
                        // Content
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

struct TravelPlanView_Previews: PreviewProvider {
    static var previews: some View {
        TravelPlanView()
    }
}

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
                        .foregroundColor(deepblue)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
                    VStack{
                        Image(systemName: "rectangle.badge.plus")
                            .foregroundColor(yellow)
                        Text("Create")
                            .foregroundColor(yellow)
                            .font(Font.custom("Gilroy-ExtraBold", size: 16))
                    }
                }
                
            }.fullScreenCover(isPresented: $showCreatePlan, onDismiss: {
                vm.fetchItems()
            }, content: {
                CreatePlanView()
                    .navigationBarHidden(true)
            })

            Spacer()
                .frame(width: 15)
            Button {

            } label: {
                ZStack{
                    Rectangle()
                        .frame(width: 162, height: 72)
                        .foregroundColor(deepblue)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
                    VStack{
                        Image(systemName: "person.3")
                            .foregroundColor(yellow)
                        Text("Join")
                            .foregroundColor(yellow)
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
                .padding(.leading, 15)
            ScrollView{
                VStack{
                    ForEach(vm.plans, id: \.recordID) {items in
                        TripCardView(plan: items.title, destination: items.destination, startDate: items.startDate, endDate: items.endDate, planID: items.recordID!)
                    }
                }
            }
        }
    }
}

// MARK: Functions

extension TravelPlanView {}
