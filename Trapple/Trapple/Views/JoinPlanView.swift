//
//  JoinPlanView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 16/09/22.
//

import SwiftUI

struct JoinPlanView: View {
    var body: some View {
//        NavigationView{
        GeometryReader{geo in
//            ZStack{
            VStack(alignment: .center){
                    Image("underCons")
                        .resizable()
                        .scaledToFit()
                        .position(x: 40, y: 130)
                        .frame(width: 100, height: 200)
                    Text("Under Development!")
                        .foregroundColor(deepblue)
                        .font(Font.custom("Gilroy-Light", size: 25))
                        .position(x: 190)

                }.navigationTitle("Join Plan")
                    .background(graybg)
//            }
        }.background(graybg)
        
//        }.background(graybg)
    }
}

struct JoinPlanView_Previews: PreviewProvider {
    static var previews: some View {
        JoinPlanView()
    }
}
