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
    @State var categoryID = CKRecord.ID()
    @State var category: String = ""
    @State var icon: String = ""
    @State var item: String = ""
    @State var description: String = ""
    @State var image: String = ""
    
    //var for submission image picker
    @State var showActionSheetCamera = false
    @State var changeSubmissionImage = false
    @State var openCameraSheet = false
    @State var imageSelected = UIImage()
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    @State var isItemName = false
    @State var isItemDescription = false
    @State var isItemImage = false
    
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if isItemName == true {
                        if vm.itemName.isEmpty{
                            VStack{
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
                                Text("Item name is required")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(Font.custom("Gilroy-Light", size: 15))
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 50)
                            }
                        }else {
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
                        }
                    }else {
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
                    }
                        
                    Spacer()
                        .frame(height: 20)
                    
                    if isItemDescription == true {
                        if vm.description.isEmpty{
                            VStack{
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
                                Text("Item description is required")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(Font.custom("Gilroy-Light", size: 15))
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 50)
                            }
                        }else {
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
                        }
                    }else {
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
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
//                    ZStack {
//                        Rectangle()
//                            .frame(height: 50)
//                            .frame(maxWidth: .infinity)
//                            .foregroundColor(tripcardColor)
//                            .cornerRadius(10)
//                            .padding(.horizontal, 30)
//                        HStack {
//                            Image(systemName: "photo")
//                                .resizable()
//                                .scaledToFit()
//                                .foregroundColor(blacktext)
//                                .frame(width: 15)
//                            Spacer()
//                                .frame(width: 20)
                            Button(action:{
                                changeSubmissionImage = true
                                showActionSheetCamera = true
                                isItemImage = true
                            }){
                                if changeSubmissionImage {
                                    ZStack{
                                        Rectangle()
                                            .frame(width: 246, height: 248)
                                        //                                .frame(maxWidth: .infinity)
                                            .foregroundColor(tripcardColor)
                                            .cornerRadius(10)
                                            .padding(.horizontal, 30)
                                        Image(uiImage: imageSelected)
                                            .resizable()
                                            .frame(width: 212, height: 215, alignment: .center)
                                            .aspectRatio(contentMode: .fit)
                                        
                                    }
                                }else {
                                    VStack{
                                        ZStack{
                                            Rectangle()
                                                .frame(height: 144)
                                                .frame(maxWidth: .infinity)
                                                .foregroundColor(tripcardColor)
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(.red, lineWidth: 1)
                                                )
                                                .padding(.horizontal, 30)
                                            HStack{
                                                Spacer()
                                                Image(systemName: "photo.on.rectangle.angled")
                                                    .resizable()
                                                    .foregroundColor(blacktext)
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 50, height: 50, alignment: .center)
                                                Spacer()
                                            }
                                        }
                                        Text("Photo is required")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(Font.custom("Gilroy-Light", size: 15))
                                            .foregroundColor(.red)
                                            .padding(.horizontal, 50)
                                    }
                                }
                            }.actionSheet(isPresented: $showActionSheetCamera) {
                                ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                                    .default(Text("Photo Library")){
                                        self.openCameraSheet = true
                                        //                            SubmissionPicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
                                        self.sourceType = .photoLibrary
                                    },
                                    .default(Text("Camera")){
                                        self.openCameraSheet = true
                                        //                            SubmissionPicker(selectedImage: $imageSelected, sourceType: .camera)
                                        self.sourceType = .camera
                                    },
                                    .cancel()
                                ])
                            }
//                            Spacer()
//                        }
//                        .padding(.horizontal, 50)
//                    }
                        
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
                        addButtonFunc()
                    }, label: {
                        Text("Add")
                            .fontWeight(.bold)
                            .foregroundColor(deepblue)
                    })
                }
            }
        }.sheet(isPresented: $openCameraSheet) {
            SubmissionPicker(selectedImage: self.$imageSelected,  sourceType: self.sourceType)
        }
        .background(graybg)

    }
}

//struct AddItemVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemVIew(showModal: .constant(true))
//    }
//}


//MARK: Function
extension AddItemVIew {
    
    func addButtonFunc() {
       
        if vm.itemName.isEmpty || vm.description.isEmpty || isItemImage == false {
            isItemName = true
            isItemDescription = true
        }
        else {
            vm.addButtonPressed(categoryID: categoryID, category: category, icon: icon, savedImage: imageSelected)
            self.showModal.toggle()

        }
    }
    
}

