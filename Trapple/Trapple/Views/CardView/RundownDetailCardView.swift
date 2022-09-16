//
//  RundownDetailCardView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 05/09/22.
//

import SwiftUI

struct RundownDetailCardView: View {
    @ObservedObject var vm: ActivitiesViewModel
    
    @State var activity: String
    @State var location: String
    @State var description: String
    @State var startTime: Date
    @State var endTime: Date
    @State var index: Int

    @State private var offsets = [CGSize](repeating: CGSize.zero, count: 6)
    @State private var isDeleted = [Bool](repeating: false, count: 6)

    static let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    var body: some View {
        ZStack {
            HStack {
                Text("Finish")
                    .foregroundColor(.white)
                    .padding(20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            .background(.red)
            
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
            .background(tripcardColor)
            .offset(x: offsets[index].width)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offsets[index] = gesture.translation
                        if offsets[index].width > 0 {
                            self.offsets[index] = .zero
                        }
                    }
                    .onEnded { _ in
                        if self.offsets[index].width < -100 {
                            self.offsets[index].width = -500
                            isDeleted[index] = true
                            vm.deleteItem(indexSet: IndexSet([index]))
                        } else if self.offsets[index].width < 0 {
                            self.offsets[index].width = .zero
                        }
                    }
            )
        }
        .font(Font.custom("Gilroy-Light", size: 11))
        .frame(maxWidth: .infinity)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
        .padding(.horizontal)
        .padding(.bottom)
        .frame(height: isDeleted[index] ? 0 : .infinity)
    }
}

// struct RundownDetailCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        RundownDetailCardView()
//    }
// }
