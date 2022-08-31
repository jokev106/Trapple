//
//  TripCardView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 26/08/22.
//

import SwiftUI
import CloudKit

struct TripCardView: View {
    
    @State var plan: String = ""
    @State var destination: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var planID: CKRecord.ID!
    
    
    static let stackDateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, dd MMMM yyyy"
            return formatter
        }()
    
    var body: some View {
        
        HStack{
            NavigationLink(destination: TripHomePageView(title: plan, planID: planID)){
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
                    Text(plan)
                        .font(Font.custom("Gilroy-ExtraBold", size: 15))
                        .lineLimit(2)
                        .padding(.trailing, 10)
                        .frame(width: 200, alignment: .leading)
                        .foregroundColor(Color.black)
                    Text(destination)
                        .font(Font.custom("Gilroy-Light", size: 12))
                        .lineLimit(2)
                        .padding(.trailing, 10)
                        .padding(.top, 0.5)
                        .frame(width: 200,alignment: .leading)
                        .foregroundColor(Color.black)
                    Text("Start: \(startDate, formatter: Self.stackDateFormat)")
                        .font(Font.custom("Gilroy-Light", size: 10))
                        .lineLimit(2)
                        .padding(.trailing, 10)
                        .padding(.top, 5)
                        .frame(width: 200,alignment: .leading)
                        .foregroundColor(Color.black)
                    Text("3 Days, 2 Night")
                        .font(Font.custom("Gilroy-Light", size: 8))
                        .lineLimit(2)
                        .padding(.trailing, 10)
                        .padding(.top, 2)
                        .frame(width: 200,alignment: .leading)
                        .foregroundColor(Color.black)
                }

                Spacer()
            }
            
        }
        .frame(height: 120)
        .background(.white)
        .cornerRadius(13)
        .padding(.bottom, 20)
        .padding(.trailing, 30)
        .padding(.leading, 30)
        .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
        .swipeActions (edge: .trailing){
            Button {
                //Function for deleting card
            } label: {
                Text("Finish")
            }.tint(Color.red)
        }
    }
}

struct TripCardView_Previews: PreviewProvider {
    static var previews: some View {
        TripCardView()
    }
}
