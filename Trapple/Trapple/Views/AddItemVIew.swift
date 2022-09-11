//
//  AddItemVIew.swift
//  Trapple
//
//  Created by Jonathan Valentino on 30/08/22.
//

import SwiftUI
import CloudKit

struct AddItemVIew: View {
    @ObservedObject var vm: EquipmentsViewModel
    @State var planID = CKRecord.ID()
    @State var category: String = ""
    @State var icon: String = ""
    @State var item: String = ""
    @State var description: String = ""
    @State var image: String = ""
    
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(tripcardColor)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                        HStack {
                            Image(systemName: "tag")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(blacktext)
                                .frame(width: 15)
                            Spacer()
                                .frame(width: 20)
                            TextField("Item Name", text: $vm.itemName)
                                .frame(width: 250, alignment: .leading)
                                .foregroundColor(blacktext)
                            Spacer()
                        }
                        .padding(.horizontal, 50)
                    }
                        
                    Spacer()
                        .frame(height: 20)
                    
                    ZStack {
                        Rectangle()
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(tripcardColor)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                        HStack {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(blacktext)
                                .frame(width: 15)
                            Spacer()
                                .frame(width: 20)
                            TextField("Item Description", text: $vm.description)
                                .frame(width: 250, alignment: .leading)
                                .foregroundColor(blacktext)
                            Spacer()
                        }
                        .padding(.horizontal, 50)
                    }
                        
                    Spacer()
                        .frame(height: 20)
                    
                    ZStack {
                        Rectangle()
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(tripcardColor)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                        HStack {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(blacktext)
                                .frame(width: 15)
                            Spacer()
                                .frame(width: 20)
                            TextField("Add Image", text: $image)
                                .frame(width: 250, alignment: .leading)
                                .foregroundColor(blacktext)
                            Spacer()
                        }
                        .padding(.horizontal, 50)
                    }
                        
                    Spacer()
                        .frame(height: 20)
                }
                .padding()
            }
            .font(Font.custom("Gilroy-Light", size: 15))
            .background(Color("grayBG"))
            .navigationBarTitle("Equipment", displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .principal){
                Text("Equipment").font(.headline)
            };
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: { self.showModal.toggle()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.yellow)
                    })
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        vm.addButtonPressed(planID: planID, category: category, icon: icon)
                        self.showModal.toggle()
                    }, label: {
                        Text("Add")
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                    })
                }
            }
        }
    }
}

//struct AddItemVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemVIew(showModal: .constant(true))
//    }
//}
