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
    
    //Bool alert
    @State var isNameBlank = false
    @State var isIconBlank = false
    
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    if isNameBlank == true {
                        if category.isEmpty{
                            VStack{
                                categoryNameIncorrect
                                Text("Category name is required")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(Font.custom("Gilroy-Light", size: 15))
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 50)
                            }
                        }else {
                            categoryName
                        }
                    }else {
                        categoryName
                    }
                        
                    Spacer()
                        .frame(height: 20)
                        
                    if isIconBlank == true {
                        if icon.isEmpty {
                            VStack{
                                chooseIconIncorrect
                                Text("Category icon is required")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(Font.custom("Gilroy-Light", size: 15))
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 50)
                            }
                        }else {
                            chooseIcon
                        }
                    }else {
                        chooseIcon
                    }
                    
                }
                .padding()
            }
            .font(Font.custom("Gilroy-Light", size: 15))
            .background(Color("grayBG"))
            .navigationBarTitle("Equipment", displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .principal){
                    Text("Equipment").font(Font.custom("Gilroy-ExtraBold", size: 18))
            };
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: { self.showModal.toggle()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(deepblue)
                    })
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        if vm.category.isEmpty || vm.icon.isEmpty {
                            isNameBlank = true
                            isIconBlank = true
                        }else {
                            vm.addButtonPressed(planID: planID, category: category, icon: icon)
                            self.showModal.toggle()
                            
                        }
                    }, label: {
                        Text("Add")
                            .fontWeight(.bold)
                            .foregroundColor(deepblue)
                    })
                }
            }
        }
        .background(graybg)
    }
}

//struct AddCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCategoryView(showModal: .constant(true))
//    }
//}


//MARK: Components
extension AddCategoryView {
    
    private var chooseIcon: some View {
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
                        .foregroundColor(blacktext)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(blacktext)
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
        .background(tripcardColor)
        .cornerRadius(10)
        .padding(.horizontal, 30)
    }
    
    private var chooseIconIncorrect: some View {
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
                        .foregroundColor(blacktext)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(blacktext)
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
        .background(tripcardColor)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.red, lineWidth: 1)
        )
        .padding(.horizontal, 30)
    }
    
    private var categoryName: some View{
        ZStack {
            Rectangle()
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .foregroundColor(tripcardColor)
                .cornerRadius(10)
                .padding(.horizontal, 30)
            HStack {
                Image(systemName: "tag")
                    .foregroundColor(blacktext)
                Spacer()
                    .frame(width: 20)
                TextField("Category Name", text: $category)
                    .frame(width: 250, alignment: .leading)
                    .foregroundColor(blacktext)
                Spacer()
            }
            .padding(.horizontal, 50)
        }
    }
    
    private var categoryNameIncorrect: some View{
        ZStack {
            Rectangle()
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .foregroundColor(tripcardColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.red, lineWidth: 1)
                )
                .padding(.horizontal, 30)
            HStack {
                Image(systemName: "tag")
                    .foregroundColor(blacktext)
                Spacer()
                    .frame(width: 20)
                TextField("Category Name", text: $category)
                    .frame(width: 250, alignment: .leading)
                    .foregroundColor(blacktext)
                Spacer()
            }
            .padding(.horizontal, 50)
        }
    }

}
