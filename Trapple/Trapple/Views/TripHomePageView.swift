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
                // RUNDOWN
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Rundown")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Description")
                        Text("Days : From - Until")
                            .opacity(0.5)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.gray)
                    .cornerRadius(15)

                    HStack {
                        VStack {
                            Spacer()
                            Text("00:00")
                                .font(.headline)
                        }
                        .padding(10)
                        
                        Rectangle()
                            .frame(width: 1)
                            .background(.black)
                        
                        VStack(alignment: .leading) {
                            Text("Activity")
                                .font(.headline)
                            Text("Location")
                                .font(.caption)
                        }
                        
                        .frame(maxWidth: 200, alignment: .leading)
                        .padding(10)
                    }
                    
                    .frame(maxWidth: .infinity)
                    .background(.yellow)
                    .cornerRadius(10)
                    .padding()
                }
                .background(.orange)
                .cornerRadius(15)
                .padding()
                
                // EQUIPMENT
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Equipment")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.gray)
                    .cornerRadius(15)

                    HStack(spacing: 0) {
                        Text("Item1")
                            .font(.headline)
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
                    .background(.yellow)
                    .cornerRadius(10)
                    .padding()
                }
                .background(.orange)
                .cornerRadius(15)
                .padding()
                
                // RULES
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Rules")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.gray)
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
                                .font(.headline)
                        }
                        
                        .frame(maxWidth: 200, alignment: .leading)
                        .padding(10)
                    }
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                .background(.orange)
                .cornerRadius(15)
                .padding()
                
                Button(action: {}, label: {
                    Text("Finish Trip")
                        .foregroundColor(.white)
                        .font(.headline)
                })
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(15)
                .padding()
            }
            .navigationBarTitle("Trip Name")
        }
    }
}

struct TripHomePageView_Previews: PreviewProvider {
    static var previews: some View {
        TripHomePageView()
    }
}
