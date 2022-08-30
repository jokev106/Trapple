////
////  RulesCardView.swift
////  Trapple
////
////  Created by Jonathan Kevin on 29/08/22.
////
//
//import SwiftUI
//
//struct RulesCardView: View {
//
//    @State var inputRules: String = ""
//    @State var inputShortDesc: String = ""
//
//    var body: some View {
//        HStack{
//            Rectangle()
//                .frame(width: 8, height: 75)
//                .cornerRadius(13)
//            Spacer()
//                .frame(width:20)
//            VStack{
//                TextField("Input Rules", text: $inputRules)
//                    .font(Font.custom("Gilroy-Light", size: 17))
//                    .frame(width: 250, alignment: .leading)
//                    .foregroundColor(.black)
//                Spacer()
//                    .frame(height:5)
//                TextField("Short Desc", text: $inputShortDesc)
//                    .font(Font.custom("Gilroy-Light", size: 14))
//                    .frame(width: 250, alignment: .leading)
//                    .foregroundColor(.black)
//            }
//            Spacer()
//        }
//        .frame(height: 120)
//        .background(.white)
//        .padding(.bottom, 20)
//        .padding(.trailing, 20)
//        .padding(.leading, 20)
//    }
//}
//
//struct RulesCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        RulesCardView()
//    }
//}
