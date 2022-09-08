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
//                NavigationView {
                    VStack {
                        // Content
                        Divider
                        // Create and Join Button
                        CreateJoinButton
                        Divider
                        OnGoingTripSection
                    }.navigationTitle("Travel Plan")
                        .background(graybg)
//                }
            }.navigationAppearance(backgroundColor: UIColor(graybg), foregroundColor: UIColor(blacktext), hideSeperator: true)
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
                Text("Create")
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.black)
                    .font(Font.custom("Gilroy-ExtraBold", size: 18))
                    .background(yellow)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
            }.sheet(isPresented: $showCreatePlan, content: {
                CreatePlanView(vm: vm)
                    .navigationBarHidden(true)
            })

            Spacer()
                .frame(width: 60)
            Text("Join")
                .frame(width: 100, height: 100)
                .foregroundColor(Color.black)
                .font(Font.custom("Gilroy-ExtraBold", size: 18))
                .background(yellow)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
                .onTapGesture {
                    // Function
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
                    }
                }
            }
        }
    }
}

// MARK: Functions

extension TravelPlanView {}
