//
//  CategoryView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 30/08/22.
//

import SwiftUI
import CloudKit

struct CategoryView: View {
    
    @StateObject private var vm = EquipmentsViewModel()
    @State var planID = CKRecord.ID()
    @State private var showModal = false
    @State var title: String
    @State var image: String

    var body: some View {
        GeometryReader { _ in
            ScrollView {
                VStack {
                    Text("Item List")
                        .font(Font.custom("Gilroy-ExtraBold", size: 17))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    ForEach(vm.equipment, id: \.recordID) { index in
                        ItemListCardview(image: image, defaultImage: true, itemName: index.itemName, description: index.description)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                }
                .onAppear{
                    vm.fetchItems(planID: planID, category: title)
                }
            }
            .background(Color("grayBG"))
            .font(Font.custom("Gilroy-Light", size: 15))
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        showModal.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add Item")
                                .font(Font.custom("Gilroy-ExtraBold", size: 17))
                        }
                        .foregroundColor(.yellow)

                    })
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    .sheet(isPresented: $showModal) {
                        AddItemVIew(vm: vm, planID: planID, category: title, icon: image, showModal: self.$showModal)
                    }
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(title: "Title", image: "photo")
    }
}
