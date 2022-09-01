//
//  RundownView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 28/08/22.
//

import SwiftUI
import CloudKit

struct RundownView: View {
    
    @StateObject private var vm = ActivitiesViewModel()
    @State var planID = CKRecord.ID()
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
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
                    SegmentedControl
                    
                    if isExist == true {
                        ForEach(vm.activity, id: \.recordID) { index in
//                            if vm.isOpen[index] == true {
//                                Button(action: { vm.isOpen[index].toggle() }) {
//                                    RundownCardviewDetail(activity: vm.activity[index].title, location: vm.activity[index].location, description: vm.activity[index].description, startTime: vm.activity[index].startDate, endTime: vm.activity[index].endDate)
//                                        .foregroundColor(.black)
//                                        .padding(.horizontal)
//                                        .padding(.vertical, 10)
//                                }
//
//                            } else {
//                                Button(action: { vm.isOpen[index].toggle() }) {
//                                    RundownCardview(activity: vm.activity[index].title, location: vm.activity[index].location, startTime: vm.activity[index].startDate)
//                                        .foregroundColor(.black)
//                                        .padding(.horizontal)
//                                        .padding(.vertical, 10)
//                                }
//                            }
                            
//                            Button(action: { vm.isOpen[0].toggle() }) {
                                RundownCardviewDetail(
//                                    activity: vm.activity[index].title, location: vm.activity[index].location, description: vm.activity[index].description, startTime: vm.activity[index].startDate, endTime: vm.activity[index].endDate
                                    activity: index.title, location: index.location, description: index.description, startTime: index.startDate, endTime: index.endDate
                                )
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
//                            }
                        }
                        .animation(.default)
                    } else {
                        VStack {
                            Text("No Activity")
                                .opacity(0.2)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height / 1.2, alignment: .center)
                    }
                }.background(graybg)
            }
            .navigationAppearance(backgroundColor: UIColor(graybg), foregroundColor: UIColor(blacktext), hideSeperator: true)
            .font(Font.custom("Gilroy-Light", size: 15))
            .navigationTitle("Rundown")
            .background(graybg)
            .onAppear{
                vm.getDates(startDate: startDate, endDate: endDate)
                vm.fetchItems(planID: planID, actualDate: vm.dates[selected])
            }
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
                        AddRundownView(planID: planID, selectedDate: selected, startDate: startDate, endDate: endDate, showModal: self.$showModal)
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
                    ForEach(vm.dates.indices, id: \.self) { index in
                        Button(action: { selected = index
                            print(selected)
                            vm.fetchItems(planID: planID, actualDate: vm.dates[selected])
                        }) {
                            VStack {
                                Text("Day \(index+1)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .opacity(selected == index ? 1.0 : 0.3)
                            
                                Text(vm.dates[index])
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
                Button(action: {
                    slider -= 1; posX += 300; selected = (slider * 3)
                    vm.fetchItems(planID: planID, actualDate: vm.dates[selected])
                }) {
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
                Button(action: {
                    slider += 1; posX -= 300; selected = (slider * 3)
                    vm.fetchItems(planID: planID, actualDate: vm.dates[selected])
                }) {
                    if slider < Int(ceil(Double(vm.dates.count) / 3) - 1) {
                        Image(systemName: "chevron.right")
                            .frame(width: 50, height: 50)
                            .padding(.bottom)
                    }
                }
                .disabled(slider < Int(ceil(Double(vm.dates.count) / 3) - 1) ? false : true)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
