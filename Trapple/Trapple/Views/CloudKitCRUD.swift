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
                textfield2
                datepicker1
                datepicker2
                addButton
                
                List{
                    ForEach(vm.plans, id: \.recordID){ item in
                        HStack{
                            Text(item.title)
                            Text(item.destination)
                        }
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
        TextField("Add Plan Name", text: $vm.title)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    private var textfield2: some View{
        TextField("Add Destination Name", text: $vm.destination)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    private var datepicker1: some View{
        DatePicker(
            "Start Date",
            selection: $vm.startDate,
            displayedComponents: [.date]
        )
    }
    
    private var datepicker2: some View{
        DatePicker(
            "End Date",
            selection: $vm.endDate,
            displayedComponents: [.date]
        )
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
