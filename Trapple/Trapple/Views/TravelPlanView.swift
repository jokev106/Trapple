//
//  TravelPlanView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 26/08/22.
//

import SwiftUI

struct TravelPlanView: View {
    var body: some View {
        GeometryReader{geo in
            ZStack{
                NavigationView{
                    VStack{
                        //Content
                        Divider
                        //Create and Join Button
                        CreateJoinButton
                        Divider
                        OnGoingTripSection
                    }.navigationTitle("Trip")
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

//MARK: Components
extension TravelPlanView {
    
    private var Divider: some View {
        SwiftUI.Divider()
            .padding(.horizontal)
    }
    
    private var CreateJoinButton: some View{
        HStack{
            Spacer()
            Text("Create")
                .frame(width: 100, height: 100)
                .foregroundColor(Color.black)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
                .onTapGesture {
                    //Function
                }
            Spacer()
                .frame(width: 60)
            Text("Join")
                .frame(width: 100, height: 100)
                .foregroundColor(Color.black)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
                .onTapGesture {
                    //Function
                }
            Spacer()

        }.padding()
    }
    
    private var OnGoingTripSection: some View{
        VStack{
            Text("On Going Trip").bold()
                .frame(width: 370, alignment: .leading)
                .foregroundColor(Color.black)
                .padding(0.5)
            ScrollView{
                VStack{
                    ForEach((1..<10)) {_ in
                        NavigationLink{
                            
                        }
                    label: {
                        TripCardView()
                    }
                    }
                }
            }
        }
    }
    
}

//MARK: Functions
extension TravelPlanView {
    
}
