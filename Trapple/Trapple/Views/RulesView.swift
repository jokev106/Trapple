//
//  RulesView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 29/08/22.
//

import SwiftUI

struct RulesView: View {
    @StateObject private var vm = RulesViewModel()
    
    @State var title: String = ""
    @State var description: String = ""
    
//    let index: Int
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                VStack {
                    // Content
                    RulesList
                    newRules
                        .background(graybg)
//                        .frame(width: 900)
                }.navigationTitle(Text("Rules"))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                // Save Data
//                                self.dataRules.onUpdate(index: self.index, inputRules: self.inputRules, inputShortDesc: self.inputShortDesc)
                            } label: {
                                Text("Save")
                                    .foregroundColor(yellow)
                            }
                        }
                    }
            }.navigationAppearance(backgroundColor: UIColor(graybg), foregroundColor: UIColor(blacktext), hideSeperator: true)
        }
    }
}

//struct RulesView_Previews: PreviewProvider {
//    static var previews: some View {
//        RulesView(index: 1).environmentObject(TripHomePageView.rulesViewModel)
//    }
//}

// MARK: Components

extension RulesView {
    private var RulesList: some View {
        VStack {
            List {
                ForEach(vm.rules, id: \.recordID) { item in
                    HStack {
                        Rectangle()
                            .frame(width: 8, height: 75)
                            .cornerRadius(13)
                            .foregroundColor(blacktext)
                        Spacer()
                            .frame(width: 20)
                        VStack {
                            TextField("\(item.title)", text: $vm.title)
                                .font(Font.custom("Gilroy-ExtraBold", size: 17))
                                .frame(width: 250, alignment: .leading)
                                .foregroundColor(.black)
                            Spacer()
                                .frame(height: 5)
                            TextField("\(item.description)", text: $vm.description)
                                .font(Font.custom("Gilroy-Light", size: 14))
                                .frame(width: 250, alignment: .leading)
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .listRowBackground(graybg)
                    .listRowSeparator(.hidden)
                    .frame(height: 80)
                    .background(graybg)
                }
                .onDelete(perform: vm.deleteItem)
//                .onMove(perform: dataRules.onMove)
                newRules
                    .frame(height: 500)
                    .background(graybg)
                    .padding(-20)
            }
        }
    }
    
    private var newRules: some View {
        VStack {
            Button {
//                self.dataRules.onAdd(rules: self.dataRules.inputRules, shortdesc: self.dataRules.inputShortDesc)
            } label: {
                Text("")
                    .background(blacktext.opacity(1))
            }.frame(maxWidth: .infinity)
        }
    }
}

// MARK: Functions

extension RulesView {}
