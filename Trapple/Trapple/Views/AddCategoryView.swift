//
//  AddCategoryView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 29/08/22.
//

import SwiftUI
import CloudKit

struct AddCategoryView: View {
    
    @ObservedObject var vm: CategoriesViewModel
    @State var planID = CKRecord.ID()
    @State var category: String = ""
    @State var icon: String = ""
    @State var listIcon = ["fork.knife", "cup.and.saucer", "scissors", "pencil.tip", "flame", "ant", "bolt", "list.dash", "car", "mouth", "cart", "bandage", "pawprint", "creditcard", "facemask", "eye", "exclamationmark.circle", "bolt.heart", "banknote", "bed.double", "alarm", "moon.zzz", "camera", "wifi", "gamecontroller", "sun.and.horizon", "trash", "play", "folder", "camera.macro"]
    
    @State private var selected = 0
    
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                        HStack {
                            Image(systemName: "tag")
                            Spacer()
                                .frame(width: 20)
                            TextField("Category Name", text: $vm.category)
                                .frame(width: 250, alignment: .leading)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.horizontal, 50)
                    }
                        
                    Spacer()
                        .frame(height: 20)
                        
                    VStack {
                        Button(action: {
                            if selected == 1 {
                                selected = 0
                            } else {
                                selected = 1
                            }
                                
                        }) {
                            HStack {
                                Text("Choose Icon")
                                    .frame(width: 250, alignment: .leading)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.black)
                            .frame(height: 50)
                            .padding(.horizontal)
                        }
                        
                        if selected == 1 {
                            VStack {
                                HStack {
                                    ForEach(0 ..< 6, id: \.self) { index in
                                        Button(action: { icon = listIcon[index] }) {
                                            ZStack {
                                                Circle()
                                                    .strokeBorder(Color.yellow, lineWidth: icon == listIcon[index] ? 2 : 0)
                                                    .frame(width: 45, height: 45)
                                                    .background(Circle().foregroundColor(Color("grayBG")))
                                                
                                                Image(systemName: listIcon[index])
                                            }
                                            .foregroundColor(.gray)
                                        }
                                    }
                                }
                                
                                HStack {
                                    ForEach(6 ..< 12, id: \.self) { index in
                                        Button(action: { icon = listIcon[index] }) {
                                            ZStack {
                                                Circle()
                                                    .strokeBorder(Color.yellow, lineWidth: icon == listIcon[index] ? 2 : 0)
                                                    .frame(width: 45, height: 45)
                                                    .background(Circle().foregroundColor(Color("grayBG")))
                                                
                                                Image(systemName: listIcon[index])
                                            }
                                            .foregroundColor(.gray)
                                        }
                                    }
                                }
                                
                                HStack {
                                    ForEach(12 ..< 18, id: \.self) { index in
                                        Button(action: { icon = listIcon[index] }) {
                                            ZStack {
                                                Circle()
                                                    .strokeBorder(Color.yellow, lineWidth: icon == listIcon[index] ? 2 : 0)
                                                    .frame(width: 45, height: 45)
                                                    .background(Circle().foregroundColor(Color("grayBG")))
                                                
                                                Image(systemName: listIcon[index])
                                            }
                                            .foregroundColor(.gray)
                                        }
                                    }
                                }
                                
                                HStack {
                                    ForEach(18 ..< 24, id: \.self) { index in
                                        Button(action: { icon = listIcon[index] }) {
                                            ZStack {
                                                Circle()
                                                    .strokeBorder(Color.yellow, lineWidth: icon == listIcon[index] ? 2 : 0)
                                                    .frame(width: 45, height: 45)
                                                    .background(Circle().foregroundColor(Color("grayBG")))
                                                
                                                Image(systemName: listIcon[index])
                                            }
                                            .foregroundColor(.gray)
                                        }
                                    }
                                }
                                
                                HStack {
                                    ForEach(24 ..< 30, id: \.self) { index in
                                        Button(action: { icon = listIcon[index] }) {
                                            ZStack {
                                                Circle()
                                                    .strokeBorder(Color.yellow, lineWidth: icon == listIcon[index] ? 2 : 0)
                                                    .frame(width: 45, height: 45)
                                                    .background(Circle().foregroundColor(Color("grayBG")))
                                                
                                                Image(systemName: listIcon[index])
                                            }
                                            .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                }
                .padding()
            }
            .font(Font.custom("Gilroy-Light", size: 15))
            .background(Color("grayBG"))
            .navigationBarTitle("Equipment", displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .principal){
                    Text("Equipment").font(Font.custom("Gilroy-ExtraBold", size: 20))
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
                        vm.addButtonPressed(planID: planID, icon: icon)
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

//struct AddCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCategoryView(showModal: .constant(true))
//    }
//}
