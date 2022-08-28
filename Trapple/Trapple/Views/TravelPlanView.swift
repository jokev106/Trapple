//
//  TravelPlanView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 26/08/22.
//

import SwiftUI

struct TravelPlanView: View {
    
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @State var createPlan = true
    
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
                    }.navigationTitle(Text("Travel Plan").font(Font.custom("Gilroy-ExtraBold", size: 48)))
                        .background(graybg)
                }
            }.navigationAppearance(backgroundColor: UIColor(graybg), foregroundColor: UIColor(blacktext), hideSeperator: true)
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
            
            Button {
                self.createPlan.toggle()
            } label: {
                Text("Create")
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.black)
                    .font(Font.custom("Gilroy-ExtraBold", size: 18))
                    .background(yellow)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
            }.sheet(isPresented: $createPlan) {
                CreatePlanView()
                    .navigationBarHidden(true)
            }
            
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
                    //Function
                }
            Spacer()
            
        }.padding()
    }
    
    private var OnGoingTripSection: some View{
        VStack{
            Text("On Going Trip").bold()
                .font(Font.custom("Gilroy-Light", size: 20))
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
