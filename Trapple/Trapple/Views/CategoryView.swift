//
//  CategoryView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 30/08/22.
//

import SwiftUI

struct CategoryView: View {
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
                    
                    ForEach(0 ..< 3, id: \.self) { index in
                        ItemListCardview(image: image, defaultImage: true)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
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
                        AddItemVIew(showModal: self.$showModal)
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
