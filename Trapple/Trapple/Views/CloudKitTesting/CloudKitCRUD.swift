//
//  CloudKitCRUD.swift
//  Trapple
//
//  Created by Vincent Leonard on 26/08/22.
//

import SwiftUI
import CloudKit

struct CloudKitCRUD: View {
    
    @StateObject private var vm = PlansViewModel()
    @State var isShowingPhoto = false
    
    var body: some View{
        NavigationView{
            VStack{
                header
                textfield
                textfield2
                datepicker1
                datepicker2
//                imagepicker
                addButton
                
                List{
                    ForEach(vm.plans, id: \.recordID){ item in
                        HStack{
                            Text(item.title)
                                .onAppear{
                                    print("RecordID: \(item.recordID)")
                                }
                            Text(item.destination)
                            
//                            if let url = item.imageURL, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
//                                Image(uiImage: image)
//                                    .resizable()
//                                    .frame(width: 50, height: 50)
//                            }
                            
                            NavigationLink(destination: CloudKitActivityTesting(planID: item.recordID! , startDate: item.startDate , endDate: item.endDate)){
                                
                            }
                        }
                    }
                    .onDelete(perform: vm.deleteItem)
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .navigationBarHidden(true)
//            .sheet(isPresented: $isShowingPhoto, content: {
//                PhotoPicker()
//            })
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
    
    private var imagepicker: some View{
        Image(uiImage: UIImage(named: "default-avatar")!)
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .padding()
            .onTapGesture {
                isShowingPhoto = true
            }
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
