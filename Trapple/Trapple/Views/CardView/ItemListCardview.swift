//
//  ItemListCardview.swift
//  Trapple
//
//  Created by Jonathan Valentino on 30/08/22.
//

import SwiftUI

struct ItemListCardview: View {
    @State var image: String
    @State var defaultImage: Bool
    @State var itemName: String = ""
    @State var description: String = ""

    var body: some View {
        HStack(spacing: 0) {
            HStack {
                if defaultImage == true {
                    Image(systemName: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)

                } else {
                    Image(systemName: image)
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(width: 100, height: 100)

            Rectangle()
                .frame(width: 5)
                .foregroundColor(Color("yellowCard"))

            VStack(alignment: .leading) {
                Text(itemName)
                    .font(Font.custom("Gilroy-ExtraBold", size: 17))
                Text(description)
                    .padding(.top, 3)
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(10)
            .padding(.leading)
            .background(.white)
        }
        .font(Font.custom("Gilroy-Light", size: 15))
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
    }
}

struct ItemListCardview_Previews: PreviewProvider {
    static var previews: some View {
        ItemListCardview(image: "photo", defaultImage: true)
    }
}
