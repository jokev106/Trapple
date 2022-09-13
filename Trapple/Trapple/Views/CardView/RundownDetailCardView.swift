//
//  RundownDetailCardView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 05/09/22.
//

import SwiftUI

struct RundownDetailCardView: View {
    @State var activity: String
    @State var location: String
    @State var description: String
    @State var startTime: Date
    @State var endTime: Date

    static let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Text(startTime, formatter: Self.stackDateFormat)
                    .font(Font.custom("Gilroy-ExtraBold", size: 13))
                    .padding(.top, 2)
                    .foregroundColor(blacktext)
                Spacer()
                    .frame(height: 25)
                Text(endTime, formatter: Self.stackDateFormat)
                    .foregroundColor(blacktext)
            }
            .frame(maxWidth: 50, maxHeight: .infinity, alignment: .top)
            .padding()

            Rectangle()
                .frame(width: 3)
                .foregroundColor(deepblue)

            VStack(alignment: .leading) {
                Text(activity)
                    .foregroundColor(blacktext)
                    .font(Font.custom("Gilroy-ExtraBold", size: 15))
                Text(location)
                    .foregroundColor(blacktext)
                Spacer()
                    .frame(height: 10)
                    .foregroundColor(blacktext)
                Text(description)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(blacktext)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .font(Font.custom("Gilroy-Light", size: 11))
        .frame(maxWidth: .infinity)
        .background(tripcardColor)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
    }
}

// struct RundownDetailCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        RundownDetailCardView()
//    }
// }
