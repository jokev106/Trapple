//
//  EquipmentView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 29/08/22.
//

import CloudKit
import SwiftUI

struct EquipmentView: View {
    @ObservedObject var vm = CategoriesViewModel()
    @State var planID = CKRecord.ID()
    @State private var showModal = false
    
    let columns = [GridItem(.adaptive(minimum: 125, maximum: 350))]
    
    var body: some View {
        GeometryReader { _ in
            ScrollView {
                VStack {
                    Text("Category List")
                        .font(Font.custom("Gilroy-ExtraBold", size: 17))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top)
                    
                    LazyVGrid(columns: columns) {
//                        EquipmentCardview(planID: planID, category: "Food & Beverages", icon: "fork.knife")
//
//                        EquipmentCardview(planID: planID, category: "Apparel", icon: "tshirt")
//
//                        EquipmentCardview(planID: planID, category: "Tools", icon: "wrench")
//
//                        EquipmentCardview(planID: planID, category: "Medicine", icon: "pills")
//
//                        EquipmentCardview(planID: planID, category: "Folder", icon: "folder")
                    
                        ForEach(vm.categoryVM, id: \.recordID) { item in
                            EquipmentCardview(categoryID: item.recordID!, category: item.category, icon: item.icon)
                            
//                            NavigationLink(destination: CategoryView(planID: planID, title: item.category, image: item.icon), label: {
//                                ZStack {
//                                    Rectangle()
//                                        .foregroundColor(.white)
//                                    VStack {
//                                        Image(systemName: item.icon)
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(height: 50)
//                                            .padding()
//
//                                        Text(item.category)
//                                    }
//                                }
//                            })
//                            .foregroundColor(.gray)
//                            .frame(height: 200)
//                            .background(.white)
//                            .cornerRadius(15)
//                            .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
//                            .padding(.horizontal, 5)
//                            .padding(.vertical, 5)
                        }
                    }
                    .padding(.horizontal)
                }
                .onAppear {
                    vm.fetchItems(planID: planID)
                }
            }
            .font(Font.custom("Gilroy-ExtraBold", size: 15))
            .navigationTitle("Equipment")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showModal.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    })
                    .sheet(isPresented: $showModal) {
                        AddCategoryView(vm: vm, planID: planID, showModal: self.$showModal)
                    }
                }
            }
        }
    }
}

struct EquipmentView_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentView()
    }
}
