//
//  RundownView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 28/08/22.
//

import SwiftUI

struct RundownView: View {
    @State private var selected = 0
    @State private var slider = 0
    @State private var posX = 0

    @State private var days = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5", "Day 6", "Day 7"]
    @State private var dates = ["August 3", "August 4", "August 5", "August 6", "August 7", "August 8", "August 9"]
    @State private var isExist = true
    @State private var nyoba = [false, false, false]
    
    @State private var showModal = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 20) {
//                        ForEach(0 ..< 10) {
//                            Text("Item \($0)")
//                                .foregroundColor(.white)
//                                .font(.headline)
//                                .frame(width: 70, height: 70)
//                                .background(.gray)
//                        }
//                    }
//                }
//                .padding()
                    
                    SegmentedControl
                    
//                    HStack {
//                        VStack {
//                            Text("SUN")
//                            ZStack {
//                                Circle()
//                                    .frame(width: 40, height: 40)
//                                    .foregroundColor(.blue)
//                                    .opacity(0.2)
//                                Text("1")
//                                    .foregroundColor(.blue)
//                                    .font(.headline)
//                            }
//                        }
//                        .frame(maxWidth: .infinity)
//
//                        VStack {
//                            Text("MON")
//                            ZStack {
//                                Circle()
//                                    .frame(width: 40, height: 40)
//                                    .foregroundColor(.blue)
//                                    .opacity(0.2)
//                                Text("2")
//                                    .foregroundColor(.blue)
//                                    .font(.headline)
//                            }
//                        }
//                        .frame(maxWidth: .infinity)
//
//                        VStack {
//                            Text("TUE")
//                            ZStack {
//                                Circle()
//                                    .frame(width: 40, height: 40)
//                                    .foregroundColor(.blue)
//                                    .opacity(0.2)
//                                Text("3")
//                                    .foregroundColor(.blue)
//                                    .font(.headline)
//                            }
//                        }
//                        .frame(maxWidth: .infinity)
//
//                        VStack {
//                            Text("WED")
//                            ZStack {
//                                Circle()
//                                    .frame(width: 40, height: 40)
//                                    .foregroundColor(.blue)
//                                    .opacity(0.2)
//                                Text("4")
//                                    .foregroundColor(.blue)
//                                    .font(.headline)
//                            }
//                        }
//                        .frame(maxWidth: .infinity)
//
//                        VStack {
//                            Text("THU")
//                            ZStack {
//                                Circle()
//                                    .frame(width: 40, height: 40)
//                                    .foregroundColor(.blue)
//                                    .opacity(0.2)
//                                Text("5")
//                                    .foregroundColor(.blue)
//                                    .font(.headline)
//                            }
//                        }
//                        .frame(maxWidth: .infinity)
//
//                        VStack {
//                            Text("FRI")
//                            ZStack {
//                                Circle()
//                                    .frame(width: 40, height: 40)
//                                    .foregroundColor(.blue)
//                                    .opacity(0.2)
//                                Text("6")
//                                    .foregroundColor(.blue)
//                                    .font(.headline)
//                            }
//                        }
//                        .frame(maxWidth: .infinity)
//
//                        VStack {
//                            Text("SAT")
//                            ZStack {
//                                Circle()
//                                    .frame(width: 40, height: 40)
//                                    .foregroundColor(.blue)
//                                    .opacity(0.2)
//                                Text("7")
//                                    .foregroundColor(.blue)
//                                    .font(.headline)
//                            }
//                        }
//                        .frame(maxWidth: .infinity)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.leading)
//                    .padding(.trailing)
                    
                    if isExist == true {
                        ForEach(0 ..< nyoba.count, id: \.self) { card in
                            if nyoba[card] == true {
                                Button(action: { nyoba[card].toggle() }) {
                                    RundownCardviewDetail()
                                        .foregroundColor(.black)
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                }
                                
                            } else {
                                Button(action: { nyoba[card].toggle() }) {
                                    RundownCardview()
                                        .foregroundColor(.black)
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                }
                            }
                        }
                        .animation(.default)
                    } else {
                        VStack {
                            Text("No Activity")
                                .opacity(0.2)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height / 1.2, alignment: .center)
                    }
                }
            }
            .font(Font.custom("Gilroy-Light", size: 15))
            .navigationTitle("Rundown")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        showModal.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add Activity")
                                .font(Font.custom("Gilroy-ExtraBold", size: 17))
                        }
                        .foregroundColor(.yellow)
                    
                    })
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    .sheet(isPresented: $showModal) {
                        AddRundownView(showModal: self.$showModal)
                    }
                }
            }
        }
    }
}

struct RundownView_Previews: PreviewProvider {
    static var previews: some View {
        RundownView()
    }
}

// MARK: Components

extension RundownView {
    private var SegmentedControl: some View {
        HStack(spacing: 0) {
            ZStack {
                VStack {
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.gray)
                }
                .frame(height: 40, alignment: .bottom)
                
                HStack(spacing: 0) {
                    ForEach(days.indices, id: \.self) { index in
                        Button(action: { selected = index }) {
                            VStack {
                                Text(days[index])
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .opacity(selected == index ? 1.0 : 0.3)
                            
                                Text(dates[index])
                                    .foregroundColor(.black)
                                    .font(Font.custom("Gilroy-Light", size: 13))
                                    .opacity(selected == index ? 0.4 : 0.2)
                            
                                Spacer()
                            
                                Rectangle()
                                    .frame(height: selected == index ? 2 : 0.5)
                                    .foregroundColor(selected == index ? .yellow : .gray)
                                    .padding(.bottom, 2)
                            }
                        }
                        .frame(width: 100, height: 40, alignment: .leading)
                        .animation(.default)
                    }
                }
                .frame(width: 300, alignment: .leading)
                .offset(x: CGFloat(posX))
                
                // LEFT
                Button(action: { slider -= 1; posX += 300; selected = (slider * 3) }) {
                    if slider > 0 {
                        Image(systemName: "chevron.left")
                            .frame(width: 50, height: 50)
                            .padding(.bottom)
                    }
                }
                .disabled(slider > 0 ? false : true)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                //RIGHT
                Button(action: { slider += 1; posX -= 300; selected = (slider * 3) }) {
                    if slider < Int(ceil(Double(days.count) / 3) - 1) {
                        Image(systemName: "chevron.right")
                            .frame(width: 50, height: 50)
                            .padding(.bottom)
                    }
                }
                .disabled(slider < Int(ceil(Double(days.count) / 3) - 1) ? false : true)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
