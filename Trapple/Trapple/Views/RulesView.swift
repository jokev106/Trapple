//
//  RulesView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 29/08/22.
//

import CloudKit
import SwiftUI

struct RulesView: View {
    @StateObject private var vm = RulesViewModel()
    @State var planID = CKRecord.ID()

    var body: some View {
        GeometryReader { _ in
            VStack {
                List {
                    // Content
                    RulesList
                }
            }
            .onAppear {
                vm.fetchItems(planID: planID)
            }
            .navigationTitle(Text("Rules"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Save Data
                        vm.addList(title: "", description: "", isAdd: true, isEdit: false)
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    })
                }
            }
//            .navigationAppearance(backgroundColor: .white, foregroundColor: UIColor(blacktext), hideSeperator: true)
        }
    }
}

// struct RulesView_Previews: PreviewProvider {
//    static var previews: some View {
//        RulesView(index: 1).environmentObject(TripHomePageView.rulesViewModel)
//    }
// }

// MARK: Components

extension RulesView {
    private var RulesList: some View {
        ForEach(vm.listAdd.indices, id: \.self) { item in
            HStack {
                Rectangle()
                    .frame(width: 8, height: 75)
                    .cornerRadius(13)
                    .foregroundColor(blacktext)
                Spacer()
                    .frame(width: 20)
                VStack {
                    TextField("Input Rules", text: $vm.listTitle[item])
                        .font(Font.custom("Gilroy-ExtraBold", size: 17))
                        .foregroundColor(.black)
                        .onChange(of: vm.listTitle[item]) { _ in
//                            vm.updateTitle(planID: planID, rule: vm.rules[item], title: vm.listTitle[item])
//                            print("Updated to \(vm.listTitle[item])!")
                            if vm.listAdd[item] == false {
                                vm.listEdit[item] = true
                            }
                        }

                    Spacer()
                        .frame(height: 5)

                    TextField("Input Description", text: $vm.listDescription[item])
                        .font(Font.custom("Gilroy-Light", size: 14))
                        .foregroundColor(.black)
                        .onChange(of: vm.listDescription[item]) { _ in
//                            vm.updateDescription(planID: planID, rule: vm.rules[item], description: vm.listDescription[item])
//                            print("Updated to \(vm.listDescription[item])!")
                            if vm.listAdd[item] == false {
                                vm.listEdit[item] = true
                            }
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()

                // Create
                if vm.listAdd[item] == true {
                    Button(action: {
                        vm.addButtonPressed(planID: planID, title: vm.listTitle[item], description: vm.listDescription[item])
                        vm.listAdd[item] = false
                    }) {
                        Text("Save")
                            .font(Font.custom("Gilroy-ExtraBold", size: 14))
                            .padding()
                    }.buttonStyle(PlainButtonStyle())
                }

                // Edit
                if vm.listEdit[item] == true {
                    Button(action: {
                        vm.updateItem(planID: planID, rule: vm.rules[item], title: vm.listTitle[item], description: vm.listDescription[item], index: IndexSet([item]))
                        vm.listEdit[item] = false
                    }) {
                        Text("Save")
                            .font(Font.custom("Gilroy-ExtraBold", size: 14))
                            .padding()
                    }.buttonStyle(PlainButtonStyle())
                }
            }
//            .listRowBackground(Color.white)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .frame(height: 100)
        }
        .onDelete(perform: vm.deleteItem)
//                .onMove(perform: dataRules.onMove)
//                newRules
//                    .frame(height: 500)
//                    .background(graybg)
//                    .padding(-20)
    }
}

// MARK: Functions

extension RulesView {}
