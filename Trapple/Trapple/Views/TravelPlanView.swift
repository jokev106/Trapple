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
                        HStack{
                            VStack{
                                Image("bali")
                                    .resizable()
                                    .padding(.trailing, 10)
                                    .frame(width: 120, height: 130)
                                    .background(Color.white)
                                    .foregroundColor(Color.gray.opacity(0.5))
                                    .cornerRadius(13)
                                    
                            }
                            
                            VStack{
                                Text("Traveling with Apple")
                                    .font(.system(size: 15, weight: .bold))
                                    .lineLimit(2)
                                    .padding(.trailing, 10)
                                    .frame(width: 200, alignment: .leading)
                                    .foregroundColor(Color.black)
                                Text("BALI, Indonesia")
                                    .font(.system(size: 12))
                                    .lineLimit(2)
                                    .padding(.trailing, 10)
                                    .padding(.top, 0.5)
                                    .frame(width: 200,alignment: .leading)
                                    .foregroundColor(Color.black)
                                Text("Start: Tuesday, 2 February 2025")
                                    .font(.system(size: 10))
                                    .lineLimit(2)
                                    .padding(.trailing, 10)
                                    .padding(.top, 5)
                                    .frame(width: 200,alignment: .leading)
                                    .foregroundColor(Color.black)
                                Text("3 Days, 2 Night")
                                    .font(.system(size: 8))
                                    .lineLimit(2)
                                    .padding(.trailing, 10)
                                    .padding(.top, 2)
                                    .frame(width: 200,alignment: .leading)
                                    .foregroundColor(Color.black)
                            }

                            Spacer()
                        }
                        .frame(height: 120)
                        .background(.white)
                        .cornerRadius(13)
                        .padding(.bottom, 20)
                        .padding(.trailing, 30)
                        .padding(.leading, 30)
                        .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
                        .onTapGesture {
                            //Function Move to Trip Page
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
