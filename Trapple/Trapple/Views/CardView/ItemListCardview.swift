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
    @State var equipmentImage: URL

    var body: some View {
        HStack(spacing: 0) {
            HStack {
                if defaultImage == true {
//                    Image(systemName: image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 50, height: 50)
                    
                    if let url = equipmentImage, let data = try? Data(contentsOf: url), let
                        image = UIImage(data: data){
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                        //                        .padding(.trailing, 10)
                        //                        .frame(width: 120, height: 130)
                        //                        .background(Color.white)
                        //                        .foregroundColor(Color.gray.opacity(0.5))
                        //                        .cornerRadius(13)
                    }

                } else {
                    Image(systemName: image)
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(width: 100)
            .frame(maxHeight: .infinity)
            
            Rectangle()
                .frame(width: 5)
                .foregroundColor(Color("yellowCard"))

            VStack(alignment: .leading, spacing: 0) {
                Text(itemName)
                    .font(Font.custom("Gilroy-ExtraBold", size: 17))
                Text(description)
                    .lineLimit(3)
                    .padding(.top, 1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
        .font(Font.custom("Gilroy-Light", size: 13))
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
    }
}

//struct ItemListCardview_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemListCardview(image: "photo", defaultImage: true)
//    }
//}
