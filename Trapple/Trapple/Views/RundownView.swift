//
//  RundownView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 28/08/22.
//

import CloudKit
import SwiftUI

struct RundownView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var vm: ActivitiesViewModel
    @Binding var planID: CKRecord.ID
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    @State private var selected = 0
    @State private var slider = 0
    @State private var posX = 0
    @State private var showModal = false
    
    // DUMMY
    @State private var days = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5", "Day 6", "Day 7"]
    @State private var dates = ["August 3", "August 4", "August 5", "August 6", "August 7", "August 8", "August 9"]
    
    @State private var isExist = true
    @State private var isOpen = CKRecord.ID(recordName: "0")
    @State private var currentDate: String = ""
    
    var body: some View {
        GeometryReader { geometry in
//            NavigationView {
            VStack {
                SegmentedControl
                VStack(spacing: 0) {
                    HStack {
                        Text(currentDate)
                            .foregroundColor(blacktext)
                            .font(Font.custom("Gilroy-ExtraBold", size: 17))
                            .onAppear {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "MMMM d"
                                let startDatestring = dateFormatter.string(from: startDate)
                                currentDate = startDatestring
                            }
                            
                        Spacer()
                            
                        Button(action: { showModal.toggle() }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                        }
                        .sheet(isPresented: $showModal) {
                            AddRundownView(vm: vm, planID: planID, selectedDate: selected, startDate: startDate, endDate: endDate, showModal: self.$showModal)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical)
                    
                    ScrollView {
                        if !vm.activity.isEmpty {
                            //                        List {
                            ForEach(vm.activity.indices, id: \.self) { index in
                                if dateFormatter(date: vm.activity[index].actualDate) == currentDate {
                                    if isOpen == vm.activity[index].recordID {
                                        Button(action: { isOpen = CKRecord.ID(recordName: "0") }) {
                                            RundownDetailCardView(vm: vm, activity: vm.activity[index].title, location: vm.activity[index].location, description: vm.activity[index].description, startTime: vm.activity[index].startDate, endTime: vm.activity[index].endDate, index: index)
                                        }
                                        
                                    } else {
                                        Button(action: {
                                            isOpen = vm.activity[index].recordID!
                                        }) {
                                            RundownCardview(vm: vm, planID: $planID, activity: vm.activity[index].title, location: vm.activity[index].location, startTime: vm.activity[index].startDate, index: index)
                                        }
                                    }
                                }
                            }
//                            .onDelete(perform: vm.deleteItem)
                            .foregroundColor(blacktext)
//                            .listRowBackground(graybg)
//                            .listRowSeparator(.hidden, edges: .all)
//                            .listRowInsets(EdgeInsets())
                            .animation(.default)
                            //                        }
                            
                        } else {
                            VStack {
                                Text("No Activity")
                                    .foregroundColor(blacktext)
                                    .opacity(0.2)
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height / 1.2, alignment: .center)
                        }
                    }
                }
            }
            .background(graybg)
            .font(Font.custom("Gilroy-Light", size: 15))
            .navigationTitle("Rundown")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: PDFView(vm: vm, planID: $planID, startDate: $startDate, endDate: $endDate), label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(blacktext)
                    })
                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        // Back to Travel Plan Screen
//                        presentationMode.wrappedValue.dismiss()
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(deepblue)
//                        Text("Back")
//                            .foregroundColor(deepblue)
//                    }
//                }
            }
            .onAppear {
                vm.resetList()
                vm.getDates(startDate: startDate, endDate: endDate)
//                }
            }
        }
        .background(graybg)
    }
    
    func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.string(from: date)
    }
}

// struct RundownView_Previews: PreviewProvider {
//    static var previews: some View {
//        RundownView()
//    }
// }

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
                .frame(height: 30, alignment: .bottom)
                
                HStack(spacing: 0) {
                    ForEach(vm.dates.indices, id: \.self) { index in
                        Button(action: { selected = index
                            print(selected)
                            currentDate = vm.dates[selected]
//                            vm.fetchItems(planID: planID, actualDate: vm.dates[selected])
                        }) {
                            VStack {
                                Text("Day \(index + 1)")
                                    .fontWeight(.bold)
                                    .foregroundColor(blacktext)
                                    .opacity(selected == index ? 1.0 : 0.3)
                            
//                                Text(vm.dates[index])
//                                    .foregroundColor(.black)
//                                    .font(Font.custom("Gilroy-Light", size: 13))
//                                    .opacity(selected == index ? 0.4 : 0.2)
                            
                                Rectangle()
                                    .frame(height: selected == index ? 2 : 0.5)
                                    .foregroundColor(selected == index ? .yellow : .gray)
                            }
                        }
                        .frame(width: 100, height: 30, alignment: .bottomLeading)
                        .animation(.default)
                    }
                }
                .frame(width: 300, alignment: .leading)
                .offset(x: CGFloat(posX))
                
                // LEFT
                Button(action: {
                    slider -= 1; posX += 300; selected = (slider * 3)
                    currentDate = vm.dates[selected]
                }) {
                    if slider > 0 {
                        VStack {
                            Image(systemName: "chevron.left")
                                .frame(width: 50, height: 25)
                                .padding(.leading)
                        }
                        .frame(height: 30, alignment: .top)
                    }
                }
                .disabled(slider > 0 ? false : true)
                .foregroundColor(blacktext)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // RIGHT
                Button(action: {
                    slider += 1; posX -= 300; selected = (slider * 3)
                    currentDate = vm.dates[selected]
                }) {
                    if slider < Int(ceil(Double(vm.dates.count) / 3) - 1) {
                        VStack {
                            Image(systemName: "chevron.right")
                                .frame(width: 50, height: 25)
                                .padding(.trailing)
                        }
                        .frame(height: 30, alignment: .top)
                    }
                }
                .disabled(slider < Int(ceil(Double(vm.dates.count) / 3) - 1) ? false : true)
                .foregroundColor(blacktext)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 5)
    }
}
