//
//  MyProfileView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 26/08/22.
//

import SwiftUI

struct MyProfileView: View {
    var body: some View {
        GeometryReader{geo in
            ZStack{
                NavigationView{
                    VStack{
                        //Content
                        Divider
                        Spacer()
                            .frame(height: 10)
                        //User Data Section (TOP)
                        UserDataSection
                        Spacer()
                            .frame(height: 20)
                        Divider
                        //History User Trip
                        Spacer()
                            .frame(height: 10)
                        HistoryUserSection
                        
                    }.navigationTitle("Profile")
                }
            }
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}

//MARK: Components
extension MyProfileView {
    
    private var Divider: some View{
        SwiftUI.Divider()
            .padding(.horizontal)
    }
    
    private var UserDataSection: some View{
        VStack{
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            Spacer()
                .frame(height: 10)
            ZStack{
                Rectangle()
                    .padding(.horizontal, 1)
                    .frame(width: 350, height: 80)
                    .cornerRadius(13)
                    .foregroundColor(.gray.opacity(0.5))
                VStack{
                    Text("Name")
                        .frame(width: 320, alignment: .leading)
                        .padding(.top, 0.5)
                        .foregroundColor(.black)
                    Rectangle()
                        .frame(width: 310, height: 1)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    Text("Age ")
                        .frame(width: 320, alignment: .leading)
                        .padding(.bottom, 0.5)
                        .foregroundColor(.black)
                    
                }
            }
        }
    }
    
    private var HistoryUserSection: some View{
        VStack{
            Text("My History").bold()
                .frame(width: 350, alignment: .leading)
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

//MARK: Function
