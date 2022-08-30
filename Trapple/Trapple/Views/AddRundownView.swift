//
//  AddRundownView.swift
//  Trapple
//
//  Created by Jonathan Valentino on 24/08/22.
//

import SwiftUI

struct AddRundownView: View {

    @State var activity: String = ""
    @State var location: String = ""
    @State var description: String = ""
    
    @State private var selected = 0
    @State private var start = Date()
    @State private var end = Date()
    
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
                    VStack(alignment: .leading) {
                        TextField("Activity", text: $activity)
                            .frame(height: 25)
                    
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.3)
                    
                        TextField("Location", text: $location)
                            .frame(height: 25)
                    
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.3)
                    
                        TextField("Description", text: $description)
                            .frame(height: 25)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)
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
                                Text("Activity")
                                
                                Spacer()
                                
                                Text(start, style: .time)
                                    .padding(5)
                                    .background(Color("grayBG"))
                                    .cornerRadius(5)
                            }
                            .frame(height: 25)
                        }
                        .foregroundColor(.black)
                        
                        if selected == 1 {
                            DatePicker("", selection: $start, displayedComponents: .hourAndMinute).datePickerStyle(WheelDatePickerStyle())
                        }
                    
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.3)
                    
                        Button(action: {
                            if selected == 2 {
                                selected = 0
                            } else {
                                selected = 2
                            }
                            
                        }) {
                            HStack {
                                Text("Location")
                            
                                Spacer()
                            
                                Text(end, style: .time)
                                    .padding(5)
                                    .background(Color("grayBG"))
                                    .cornerRadius(5)
                            }
                            .frame(height: 25)
                        }
                        .foregroundColor(.black)
                        
                        if selected == 2 {
                            DatePicker("", selection: $end, displayedComponents: .hourAndMinute).datePickerStyle(WheelDatePickerStyle())
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(15)
                    .padding()
                }
            }
            .font(Font.custom("Gilroy-Light", size: 15))
            .background(Color("grayBG"))
            .navigationBarTitle("Activity", displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: { self.showModal.toggle()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.yellow)
                    })
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                           self.showModal.toggle()
                    }, label: {
                        Text("Add")
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                    })
                }
            }
        }
    }
    
    func textIsAppropiate() -> Bool {
        if activity.count >= 1 {
            return true
        }
        
        return false
    }
    
    
}

struct AddRundownView_Previews: PreviewProvider {
    static var previews: some View {
        AddRundownView(showModal: .constant(true))
    }
}

//#if canImport(UIKit)
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
//#endif
