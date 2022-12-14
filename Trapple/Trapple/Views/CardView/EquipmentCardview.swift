//
//  EquipmentCardview.swift
//  Trapple
//
//  Created by Jonathan Valentino on 30/08/22.
//

import SwiftUI
import CloudKit

struct EquipmentCardview: View {
    @ObservedObject var vm: CategoriesViewModel
    @State var planID = CKRecord.ID()
    @State var categoryID = CKRecord.ID()
    @State var category: String
    @State var icon: String
    @State var categoryIndex: IndexSet
    
    var body: some View {
        ZStack {
            NavigationLink(destination: CategoryView(categoryID: categoryID, title: category, image: icon), label: {
                VStack(alignment: .leading) {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                    
                    Spacer()
                    
                    Text(category)
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
                vm.deleteItem(indexSet: categoryIndex, planID: planID)
            }, label: {
                Image(systemName: "minus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 7)
                    .foregroundColor(deepblue)
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

//struct EquipmentCardview_Previews: PreviewProvider {
//    static var previews: some View {
//        EquipmentCardview()
//    }
//}
