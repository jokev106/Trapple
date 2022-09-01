//
//  RundownCardview.swift
//  Trapple
//
//  Created by Jonathan Valentino on 29/08/22.
//

import SwiftUI

struct RundownCardview: View {
    
    @State var activity: String
    @State var location: String
    @State var startTime: Date
    
    var body: some View {
        HStack(spacing: 0) {
            Text(startTime, format: Date.FormatStyle().hour().minute())
                .font(Font.custom("Gilroy-ExtraBold", size: 13))
                .padding()
            
            Rectangle()
                .frame(width: 3)
                .foregroundColor(Color("yellowCard"))
            
            VStack(alignment: .leading) {
                Text(activity)
                    .font(Font.custom("Gilroy-ExtraBold", size: 15))
                Text(location)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .padding(.leading)
        }
        .font(Font.custom("Gilroy-Light", size: 11))
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
    }
}

//struct RundownCardview_Previews: PreviewProvider {
//    static var previews: some View {
//        RundownCardview()
//    }
//}
