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
    @State var planID: CKRecord.ID
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
                        .padding(.horizontal, 25)
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
                    
                        ForEach(vm.categoryVM.indices, id: \.self) { item in
//                            EquipmentCardview(vm: vm, planID: planID, categoryID: vm.categoryVM[item].recordID!, category: vm.categoryVM[item].category, icon: vm.categoryVM[item].icon, categoryIndex: IndexSet([item]))
                            
                            ZStack {
                                NavigationLink(destination: CategoryView(categoryID: vm.categoryVM[item].recordID!, title: vm.categoryVM[item].category, image: vm.categoryVM[item].icon), label: {
                                    VStack(alignment: .leading) {
                                        Image(systemName: vm.categoryVM[item].icon)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 30)
                                        
                                        Spacer()
                                        
                                        Text(vm.categoryVM[item].category)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .foregroundColor(deepblue)
                                    .padding()
                                    .frame(height: 100)
                                    .background(lightpurple)
                                    .cornerRadius(15)
                                    .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 5)
                                })
                                
                                Button(action: {
                                    vm.deleteItem(indexSet: IndexSet([item]), planID: planID)
                                }, label: {
                                    Image(systemName: "minus")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 7)
                                        .foregroundColor(.black)
                                        .padding(7)
                                        .background(.white)
                                        .clipShape(Circle())
                                })
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
                                .padding()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(graybg)
            .onAppear {
                vm.fetchItems(planID: planID)
            }
        }
        .background(graybg)
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

// struct EquipmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EquipmentView()
//    }
// }
