//
//  CloudKitCRUD.swift
//  Trapple
//
//  Created by Vincent Leonard on 26/08/22.
//

import SwiftUI

struct CloudKitCRUD: View {
    
    @StateObject private var vm = CloudKitCRUDViewModel()
    
    var body: some View{
        NavigationView{
            VStack{
                header
                textfield
                addButton
                
                List{
                    ForEach(vm.plans, id: \.self){
                        Text($0)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct CloudKitCRUD_Previews: PreviewProvider{
    static var previews: some View{
        CloudKitCRUD()
    }
}

extension CloudKitCRUD {
    
    private var header: some View{
        Text("CloudKit CRUD")
    }
    
    private var textfield: some View{
        TextField("Add Plan Name", text: $vm.text)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    private var addButton: some View{
        Button{
            vm.addButtonPressed()
        } label: {
            Text("Add")
                .frame(height: 55)
                .foregroundColor(.white)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}
