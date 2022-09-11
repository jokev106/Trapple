//
//  TripCardView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 26/08/22.
//

import CloudKit
import SwiftUI

struct TripCardView: View {
    @ObservedObject var vm: PlansViewModel
    @State var plan: String = ""
    @State var destination: String = ""
    @State var startDate: Date = .init()
    @State var endDate: Date = .init()
    @State var planID: CKRecord.ID

    static let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM yyyy"
        return formatter
    }()

    var body: some View {
        HStack {
            NavigationLink(destination: TripHomePageView(title: $plan, destination: $destination, planID: $planID, startDate: $startDate, endDate: $endDate)) {
                Image("bali")
                    .resizable()
                    .padding(.trailing, 10)
                    .frame(width: 120, height: 130)
                    .background(tripcardColor)
                    .foregroundColor(Color.gray.opacity(0.5))
                    .cornerRadius(13)

                VStack {
                    Text(plan)
                        .font(Font.custom("Gilroy-ExtraBold", size: 15))
                        .lineLimit(2)
                        .padding(.trailing, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(blacktext)
                    Text(destination)
                        .font(Font.custom("Gilroy-Light", size: 12))
                        .lineLimit(2)
                        .padding(.trailing, 10)
                        .padding(.top, 0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(blacktext)
                    Text("Start: \(startDate, formatter: Self.stackDateFormat)")
                        .font(Font.custom("Gilroy-Light", size: 10))
                        .lineLimit(2)
                        .padding(.trailing, 10)
                        .padding(.top, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(blacktext)
                    Text("\(vm.getDateRange(startDate: startDate, endDate: endDate)) Days, \(vm.getDateRange(startDate: startDate, endDate: endDate) - 1) Nights")
                        .font(Font.custom("Gilroy-Light", size: 8))
                        .lineLimit(2)
                        .padding(.trailing, 10)
                        .padding(.top, 2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(blacktext)
                }
                Spacer()
                    .frame(width: 10)
            }
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .frame(height: 120)
        .background(tripcardColor)
        .cornerRadius(13)
//        .padding(.bottom, 20)
//        .padding(.trailing, 30)
//        .padding(.leading, 30)
        .shadow(color: Color.gray.opacity(0.275), radius: 8, x: 2, y: 4)
//        .swipeActions(edge: .trailing) {
//            Button {
//                vm.deleteItem(indexSet: <#T##IndexSet#>)
//            } label: {
//                Text("Finish")
//            }.tint(Color.red)
//        }
    }
}

// struct TripCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripCardView()
//    }
// }
