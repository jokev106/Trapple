//
//  AddRundownView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 24/08/22.
//

import SwiftUI
import CloudKit

struct AddRundownView: View {
    
    @ObservedObject var vm = ActivitiesViewModel()
    @State var planID = CKRecord.ID()
    @State var selectedDate: Int
    @State var startDate: Date
    @State var endDate: Date

    @State var activity: String = ""
    @State var location: String = ""
    @State var description: String = ""
    
    @State private var selected = 0
    @State private var start = Date()
    @State private var end = Date()
    
    //Bool for alert black space
    @State var isFormBlank = false
    
    @Binding var showModal: Bool
    
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .none
//        formatter.timeStyle = .short
//        return formatter
//    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if isFormBlank == true {
                        ZStack{
                            Text("The activity and location  is required.\n  Please fill in the blank to add new activity")
//                                .multilineTextAlignment(2)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height: 60)
                                .foregroundColor(.red)
                                .background(redalert)
                                .multilineTextAlignment(.center)
                                .cornerRadius(10)
                                .font(Font.custom("Gilroy-Light", size: 15))
                                .padding()
                        }
                    }else {
                        Spacer()
                            .frame(height:1)
                    }
                    VStack(alignment: .leading) {
                        
                        TextField("Activity", text: $vm.title)
                            .foregroundColor(blacktext)
                            .frame(height: 25)
                    
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(blacktext)
                            .opacity(0.3)
                    
                        TextField("Location", text: $vm.location)
                            .frame(height: 25)
                            .foregroundColor(blacktext)
                    
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.3)
                            .foregroundColor(blacktext)
                    
                        TextField("Description", text: $vm.description)
                            .frame(height: 25)
                            .foregroundColor(blacktext)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(tripcardColor)
                    .cornerRadius(15)
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Button(action: {
                            if selected == 1 {
                                selected = 0
                            } else {
                                selected = 1
                            }
                            
                        }) {
                            HStack {
                                Text("Start Time")
                                    .foregroundColor(blacktext)
                                
                                Spacer()
                                
                                Text(vm.startDate, style: .time)
                                    .padding(5)
                                    .background(graytimebg)
                                    .cornerRadius(5)
                            }
                            .frame(height: 25)
                        }
                        .foregroundColor(blacktext)
                        
                        if selected == 1 {
                            DatePicker("", selection: $vm.startDate, displayedComponents: .hourAndMinute).datePickerStyle(WheelDatePickerStyle())
                                .foregroundColor(blacktext)
                        }
                    
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(blacktext)
                            .opacity(0.3)
                    
                        Button(action: {
                            if selected == 2 {
                                selected = 0
                            } else {
                                selected = 2
                            }
                            
                        }) {
                            HStack {
                                Text("End Time")
                                    .foregroundColor(blacktext)
                            
                                Spacer()
                            
                                Text(vm.endDate, style: .time)
                                    .padding(5)
                                    .background(graytimebg)
                                    .cornerRadius(5)
                            }
                            .frame(height: 25)
                        }
                        .foregroundColor(blacktext)
                        
                        if selected == 2 {
                            DatePicker("", selection: $vm.endDate, displayedComponents: .hourAndMinute).datePickerStyle(WheelDatePickerStyle())
                                .foregroundColor(blacktext)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(tripcardColor)
                    .cornerRadius(15)
                    .padding()
                }
            }
            .font(Font.custom("Gilroy-Light", size: 15))
            .background(Color("grayBG"))
            .navigationBarTitle("Activity", displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .principal){
                    Text("Activity").font(Font.custom("Gilroy-ExtraBold", size: 18))
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
                        if vm.activity.isEmpty || vm.location.isEmpty || vm.description.isEmpty {
                            isFormBlank = true
                        }else{
                            vm.addButtonPressed(planID: planID, actualDate: vm.dates[selectedDate])
                            print(vm.dates)
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
        .onAppear{
            vm.getDates(startDate: startDate, endDate: endDate)
        }
    }
    
    func textIsAppropiate() -> Bool {
        if activity.count >= 1 {
            return true
        }
        
        return false
    }
    
    
}

//struct AddRundownView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRundownView(showModal: .constant(true))
//    }
//}

//#if canImport(UIKit)
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
//#endif
