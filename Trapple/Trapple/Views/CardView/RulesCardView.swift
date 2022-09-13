//
//  RulesCardView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 29/08/22.
//

import SwiftUI
import CloudKit

struct RulesCardView: View {
    @ObservedObject var vm: RulesViewModel
    @State var planID: CKRecord.ID
    @State var item: Int

    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 8, height: 75)
                .cornerRadius(13)
                .foregroundColor(blacktext)
            Spacer()
                .frame(width: 20)
            VStack {
                TextField("Input Rules", text: $vm.listTitle[item])
                    .font(Font.custom("Gilroy-ExtraBold", size: 20))
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
                    .font(Font.custom("Gilroy-Light", size: 15))
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
}

//struct RulesCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        RulesCardView()
//    }
//}
