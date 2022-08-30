//
//  RundownCardviewDetail.swift
//  Trapple
//
//  Created by Jonathan Valentino on 29/08/22.
//

import SwiftUI

struct RundownCardviewDetail: View {
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Text("00:00")
                    .font(Font.custom("Gilroy-ExtraBold", size: 13))
                Text("00:00")
                    .padding(.top, 1)
            }
            .padding()

            Rectangle()
                .frame(width: 3)
                .foregroundColor(Color("yellowCard"))

            VStack(alignment: .leading) {
                Text("Activity")
                    .font(Font.custom("Gilroy-ExtraBold", size: 15))
                Text("Location")
                VStack {
                    Text("Description")
                }
                .frame(height: 40, alignment: .top)
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

struct RundownCardviewDetail_Previews: PreviewProvider {
    static var previews: some View {
        RundownCardviewDetail()
    }
}