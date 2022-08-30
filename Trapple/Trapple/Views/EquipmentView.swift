//
//  EquipmentView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 29/08/22.
//

import SwiftUI

struct EquipmentView: View {
    @State private var showModal = false
    
    let columns = [GridItem(.adaptive(minimum: 125, maximum: 350))]
    
    var body: some View {
        GeometryReader { _ in
            ScrollView {
                VStack {
                    Text("Category List")
                        .font(Font.custom("Gilroy-ExtraBold", size: 17))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top)
                    
                    LazyVGrid(columns: columns) {
                        NavigationLink(destination: CategoryView(title: "Food & Beverages", image: "fork.knife"), label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                VStack {
                                    Image(systemName: "fork.knife")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)
                                        .padding()
                                
                                    Text("Food & Beverages")
                                }
                            }
                        })
                        .foregroundColor(.gray)
                        .frame(height: 200)
                        .background(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                        
                        NavigationLink(destination: CategoryView(title: "Apparel", image: "tshirt"), label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                VStack {
                                    Image(systemName: "tshirt")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)
                                        .padding()
                                
                                    Text("Apparel")
                                }
                            }
                        })
                        .foregroundColor(.gray)
                        .frame(height: 200)
                        .background(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                        
                        NavigationLink(destination: CategoryView(title: "Tools", image: "wrench"), label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                VStack {
                                    Image(systemName: "wrench")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)
                                        .padding()
                                
                                    Text("Tools")
                                }
                            }
                        })
                        .foregroundColor(.gray)
                        .frame(height: 200)
                        .background(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                    
                        NavigationLink(destination: CategoryView(title: "Medicine", image: "pills"), label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                VStack {
                                    Image(systemName: "pills")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)
                                        .padding()
                                
                                    Text("Medicine")
                                }
                            }
                        })
                        .foregroundColor(.gray)
                        .frame(height: 200)
                        .background(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                        
                        ForEach(0 ..< 1, id: \.self) { _ in
                            NavigationLink(destination: CategoryView(title: "Custom", image: "folder"), label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                    VStack {
                                        Image(systemName: "folder")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 50)
                                            .padding()
                                    
                                        Text("Custom")
                                    }
                                }
                            })
                            .foregroundColor(.gray)
                            .frame(height: 200)
                            .background(.white)
                            .cornerRadius(15)
                            .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color("grayBG"))
            .font(Font.custom("Gilroy-ExtraBold", size: 15))
            .navigationTitle("Equipment")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        showModal.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add Category")
                                .font(Font.custom("Gilroy-ExtraBold", size: 17))
                        }
                        .foregroundColor(.yellow)
                    
                    })
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    .sheet(isPresented: $showModal) {
                        AddCategoryView(showModal: self.$showModal)
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
