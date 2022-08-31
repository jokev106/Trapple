//
//  CreatePlanView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 26/08/22.
//

import SwiftUI


struct CreatePlanView: View {
    
    
    //var for form input
    @State var inputTripName: String = ""
    @State var inputDestination: String = ""
    @State var startDate = Date()
    @State var endDate = Date()
    
    //bool for showing date picker
    @State var showEndDate = false
    @State var showStartDate = false
    
    //Dismiss the view
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    //var for submission image picker
    @State var changeSubmissionImage = false
    @State var openCameraSheet = false
    @State var imageSelected = UIImage()
    
    
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

struct CreatePlanView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlanView()
    }
}

//MARK: Components
extension CreatePlanView {
    
    private var PlanForm : some View{
        VStack{
            Group{
                Text("Let’s get started with your trip plan.")
                    .font(Font.system(size: 15))
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
                        SubmissionPicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
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
                    TextField("Trip Name", text: $inputTripName)
                        .frame(width: 250, alignment: .leading)
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
                    TextField("Destination", text: $inputTripName)
                        .frame(width: 250, alignment: .leading)
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
            Text("Create")
                .fontWeight(.bold)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.5))
                .foregroundColor(.black)
                .cornerRadius(10)
                .onTapGesture {
                    //Function Save trip plan data + Move to Trip Page
                }
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
                                Text("Set Start Date")
                                    .foregroundColor(.gray)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 50)
                        .padding(.top, 15)
                        DatePicker("Set Start Date", selection: $startDate, in: Date()..., displayedComponents: .date)
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
                            }
                        }, label: {
                            Text("Set Start Date")
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
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
                                Text("Set End Date")
                                    .foregroundColor(.gray)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 50)
                        .padding(.top, 15)
                        DatePicker("Set Start Date", selection: $startDate, in: Date()..., displayedComponents: .date)
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
                            }
                        }, label: {
                            Text("Set End Date")
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
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
