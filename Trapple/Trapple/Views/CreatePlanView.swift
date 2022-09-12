//
//  CreatePlanView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 26/08/22.
//

import SwiftUI
import CloudKit


struct CreatePlanView: View {
    
    @ObservedObject var vm: PlansViewModel
    //var for form input
    //    @State var inputTripName: String = ""
    //    @State var inputDestination: String = ""
    //    @State var startDate = Date()
    //    @State var endDate = Date()
    
    //bool for showing date picker
    @State var showEndDate = false
    @State var showStartDate = false
    
    //bool for showing value while date picker is false
    @State var valueEndDate = false
    @State var valueStartDate = false
    
    //Dismiss the view
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    //var for submission image picker
    @State var changeSubmissionImage = false
    @State var openCameraSheet = false
    @State var imageSelected = UIImage()
    
    @State var setstartdate = "Set Start Date"
    
    static let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM yyyy"
        return formatter
    }()
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                NavigationView{
                    VStack{
                        ScrollView{
                            //Content
                            PlanForm
                            Spacer()
                            
                        }
                        CreateButton
                    }.navigationTitle("Create Plan")
                        .background(graybg)
                        .toolbar{
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button{
                                    //Back to Travel Plan Screen
                                    presentationMode.wrappedValue.dismiss()
                                }label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(yellow)
                                    Text("Back")
                                        .foregroundColor(yellow)
                                    
                                }
                            }
                        }
                }
            }
        }
    }
}

//struct CreatePlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePlanView()
//    }
//}

//MARK: Components
extension CreatePlanView {
    
    private var PlanForm : some View{
        VStack{
            Group{
                Text("Let’s get started with your trip plan.")
                    .font(Font.custom("Gilroy-Light", size: 15))
                    .frame(width: 350, alignment: .leading)
                
                Spacer()
                    .frame(height: 40)
            }
            //Trip Photos
            Group{
                //Add photo from library
                Button(action:{
                    changeSubmissionImage = true
                    openCameraSheet = true
                }){
                    if changeSubmissionImage {
                        ZStack{
                            Rectangle()
                                .frame(width: 246, height: 248)
                            //                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 30)
                            Image(uiImage: imageSelected)
                                .resizable()
                                .frame(width: 212, height: 215, alignment: .center)
                                .aspectRatio(contentMode: .fit)
                            
                        }
                    }else {
                        ZStack{
                            Rectangle()
                                .frame(height: 144)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .cornerRadius(10)
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
                    }
                }.sheet(isPresented: $openCameraSheet) {
                    SubmissionPicker(selectedImage: $imageSelected, sourceType: .camera)
                }
                Spacer()
                    .frame(height: 10)
            }
            
            //Trip Name Form
            ZStack{
                Rectangle()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                HStack{
                    Image(systemName: "pencil")
                    Spacer()
                        .frame(width: 20)
                    TextField("Trip Name", text: $vm.title)
                        .frame(width: 250, alignment: .leading)
                        .font(Font.custom("Gilroy-Light", size: 15))
                        .foregroundColor(.black)
                    Spacer()
                }.padding(.horizontal, 50)
            }
            Spacer()
                .frame(height: 10)
            //Trip Destination Form
            ZStack{
                Rectangle()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                HStack{
                    Image(systemName: "airplane")
                    Spacer()
                        .frame(width: 20)
                    TextField("Destination", text: $vm.destination)
                        .frame(width: 250, alignment: .leading)
                        .font(Font.custom("Gilroy-Light", size: 15))
                        .foregroundColor(.black)
                    Spacer()
                }.padding(.horizontal, 50)
            }
            Spacer()
                .frame(height: 10)
            //Trip Start Date Form
            TripStartDate
            Spacer()
                .frame(height: 10)
            //Trip End Date Form
            TripEndDate
            
            Spacer()
                .frame(height: 10)
            
        }
        
    }
    
    private var CreateButton : some View {
        VStack{
            
            //            NavigationLink(destination: TripHomePageView(), label: {
            Text("Create")
                .fontWeight(.bold)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.5))
                .foregroundColor(.black)
                .cornerRadius(10)
                .onTapGesture {
                    //Function Save trip plan data + Move to Trip Page
                    vm.addButtonPressed(savedImage: imageSelected)
                    presentationMode.wrappedValue.dismiss()
                }
            //            })
        }.padding(20)
        
    }
    
    private var TripStartDate : some View{
                VStack{
                    if showStartDate == true{
                        ZStack{
                            Rectangle()
                                .frame(height: 350)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 30)
                            VStack{
                                HStack{
                                    Image(systemName: "calendar")
                                    Spacer()
                                        .frame(width: 20)
                                    Button {
                                        withAnimation{
                                            self.showStartDate.toggle()
                                        }
                                    } label: {
                                        Text(valueStartDate ?  "\(vm.startDate, formatter: CreatePlanView.stackDateFormat)" : "Set Start Date")
                                            .foregroundColor(valueStartDate ? .black : .gray)
                                            .font(Font.custom("Gilroy-Light", size: 15))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                            .rotationEffect(.degrees(showStartDate ? 90 : 0))
                                            .animation(.easeInOut(duration: 4), value: showStartDate)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal, 50)
                                .padding(.top, 15)
                                DatePicker("Set Start Date", selection: $vm.startDate, in: Date()..., displayedComponents: .date)
                                    .accentColor(yellow)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .frame(height: 300)
                                    .labelsHidden()
                                    .padding(.horizontal, 50)
                                Spacer()
                            }
                        }

                    }else{
                        ZStack{
                            Rectangle()
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 30)
                            HStack{
                                Image(systemName: "calendar")
                                Spacer()
                                    .frame(width: 20)
                                Button(action: {
                                    withAnimation{
                                        self.showStartDate.toggle()
                                        valueStartDate = true
                                        showEndDate = false
                                    }
                                }, label: {
                                    Text((valueStartDate ? "\(vm.startDate, formatter: CreatePlanView.stackDateFormat)" : "Set Start Date"))
                                        .foregroundColor(valueStartDate ? .black : .gray)
                                        .font(Font.custom("Gilroy-Light", size: 15))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                        .rotationEffect(.degrees(showStartDate ? 90 : 0))
                                        .animation(.easeInOut(duration: 4), value: showStartDate)
                                })
                                Spacer()
                            }.padding(.horizontal, 50)
                        }
                    }
                }
    }
    
    private var TripEndDate : some View{
        VStack{
            if showEndDate == true{
                ZStack{
                    Rectangle()
                        .frame(height: 350)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    VStack{
                        HStack{
                            Image(systemName: "calendar")
                            Spacer()
                                .frame(width: 20)
                            Button {
                                withAnimation{
                                    self.showEndDate.toggle()
                                }
                            } label: {
                                Text((valueEndDate ? "\(vm.endDate, formatter: CreatePlanView.stackDateFormat)" : "Set End Date"))
                                    .foregroundColor(valueEndDate ? .black : .gray)
                                    .font(Font.custom("Gilroy-Light", size: 15))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .rotationEffect(.degrees(showEndDate ? 90 : 0))
                                    .animation(.easeInOut(duration: 4), value: showEndDate)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 50)
                        .padding(.top, 15)
                        DatePicker("Set End Date", selection: $vm.endDate, in: Date()..., displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .frame(height: 300)
                            .accentColor(yellow)
                            .labelsHidden()
                            .padding(.horizontal, 50)
                        Spacer()
                    }
                }
                
            }else{
                ZStack{
                    Rectangle()
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    HStack{
                        Image(systemName: "calendar")
                        Spacer()
                            .frame(width: 20)
                        Button(action: {
                            withAnimation{
                                self.showEndDate.toggle()
                                valueEndDate = true
                                showStartDate = false
                            }
                        }, label: {
                            Text((valueEndDate ? "\(vm.endDate, formatter: CreatePlanView.stackDateFormat)" : "Set End Date"))
                                .foregroundColor(valueEndDate ? .black : .gray)
                                .font(Font.custom("Gilroy-Light", size: 15))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .rotationEffect(.degrees(showEndDate ? 90 : 0))
                                .animation(.easeInOut(duration: 4), value: showEndDate)
                        })
                        
                        //                    DatePicker("Set Start Date", selection: $startDate, in: Date()..., displayedComponents: .date)
                        
                        
                        Spacer()
                    }.padding(.horizontal, 50)
                }
            }
        }
    }
    
}

//MARK: Function
extension CreatePlanView {
    
    
    
}


