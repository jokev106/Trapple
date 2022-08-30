//
//  CloudKitActivityTesting.swift
//  Trapple
//
//  Created by Vincent Leonard on 29/08/22.
//

import SwiftUI
import CloudKit

struct CloudKitActivityTesting: View {
    @StateObject private var vm = ActivitiesViewModel()
    @State var planID = CKRecord.ID()
    @State var loopDate = Date()
    @State var currentDate = Date()
    
    @State var startDate = Date()
    @State var endDate = Date()
    
    var body: some View{
        NavigationView{
            VStack{
                header
                textfield
                textfield2
                textfield3
                datepicker1
                datepicker2
                addButton
                
                
                
                List{
                    ForEach(vm.activity, id: \.recordID){ item in
                        HStack{
                            Text(item.title)
                            Text(item.location)
                            Text(item.description)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .navigationBarHidden(true)
        }
        .onAppear{
            vm.fetchItems(planID: planID)
        }
    }
}

struct CloudKitActivityTesting_Previews: PreviewProvider{
    static var previews: some View{
        CloudKitActivityTesting()
    }
}

extension CloudKitActivityTesting {
    
    private var header: some View{
        Text("CloudKit CRUD")
    }
    
    private var textfield: some View{
        TextField("Add Activity Name", text: $vm.title)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    private var textfield2: some View{
        TextField("Add Location Name", text: $vm.location)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    private var textfield3: some View{
        TextField("Add Description", text: $vm.description)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    private var datepicker1: some View{
        DatePicker(
            "Start Date",
            selection: $vm.startDate,
            displayedComponents: [.hourAndMinute]
        )
    }
    
    private var datepicker2: some View{
        DatePicker(
            "End Date",
            selection: $vm.endDate,
            displayedComponents: [.hourAndMinute]
        )
    }
    
    private var addButton: some View{
        Button{
            vm.addButtonPressed(planID: planID)
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

