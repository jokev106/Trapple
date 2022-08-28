//
//  TripHomePageView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 24/08/22.
//

import SwiftUI

struct TripHomePageView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Rundown
                    Equipment
                    Rules
                }
            }
            .background(Color("grayBG"))
            .font(Font.custom("Gilroy-Light", size: 20))
            .navigationTitle("Trip Name")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.black)
                    })
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
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
        VStack(spacing: 0) {
            NavigationLink(destination: RundownView(), label: {
                VStack(alignment: .leading) {
                    Text("Rundown")
                        .fontWeight(.bold)
                    Text("Description".uppercased())
                        .font(Font.custom("Gilroy-Light", size: 18))
                    Text("Days : From - Until")
                        .font(Font.custom("Gilroy-Light", size: 15))
                        .opacity(0.5)
                }
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color("yellowCard"))
                .cornerRadius(15)
            })

            HStack(spacing: 0) {
                Text("00:00")
                    .font(Font.custom("Gilroy-Light", size: 15))
                    .fontWeight(.bold)
                    .padding()
                
                Rectangle()
                    .frame(width: 1)
                    .foregroundColor(Color("yellowCard"))
                
                VStack(alignment: .leading) {
                    Text("Activity")
                    Text("Location")
                        .font(Font.custom("Gilroy-Light", size: 15))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .padding(.leading)
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(15)
            .shadow(radius: 1)
            .padding()
        }
        .background(.white)
        .cornerRadius(15)
        .padding()
    }
    
    private var Equipment: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("Equipment")
                    .fontWeight(.bold)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("yellowCard"))
            .cornerRadius(15)

            HStack(spacing: 0) {
                Text("Item1")
                    .padding(10)
            
                Spacer()
            
                ZStack {
                    Rectangle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                        .cornerRadius(5)
                        .padding(10)
                
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .cornerRadius(15)
            .shadow(radius: 1)
            .padding()
        }
        .background(.white)
        .cornerRadius(15)
        .padding()
    }
    
    private var Rules: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("Rules")
                    .fontWeight(.bold)
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
                }
            
                .frame(maxWidth: 200, alignment: .leading)
                .padding(10)
            }
        
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .background(.white)
        .cornerRadius(15)
        .padding()
    }
}
