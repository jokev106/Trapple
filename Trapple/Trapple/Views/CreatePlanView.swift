//
//  CreatePlanView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 26/08/22.
//

import SwiftUI
import CloudKit


struct CreatePlanView: View {
    
    @StateObject private var vm = PlansViewModel()
    //var for form input
    //    @State var inputTripName: String = ""
    //    @State var inputDestination: String = ""
    //    @State var startDate = Date()
    //    @State var endDate = Date()
    
    //bool for validation form
    @State var tripNameValidation = false
    @State var destinationValidation = false
    @State var startDateValidation = false
    @State var endDateValidation = false
    @State var createButtonOn = false
    
    //bool for showing date picker
    @State var showEndDate = false
    @State var showStartDate = false
    
    //bool for showing value while date picker is false
    @State var valueEndDate = false
    @State var valueStartDate = false
    
    //Dismiss the view
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    //var for submission image picker
    @State var showActionSheetCamera = false
    @State var changeSubmissionImage = false
    @State var openCameraSheet = false
    @State var imageSelected = UIImage()
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
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
                                        .foregroundColor(deepblue)
                                    Text("Back")
                                        .foregroundColor(deepblue)
                                    
                                }
                            }
                        }
                }.sheet(isPresented: $openCameraSheet) {
                    SubmissionPicker(selectedImage: self.$imageSelected,  sourceType: self.sourceType)
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
                    .font(Font.custom("Gilroy-Light", size: 15))
                    .frame(width: 350, alignment: .leading)
                
                Spacer()
                    .frame(height: 40)
            }
            //Trip Photos
            Group{
//                Add photo from library
                Button(action:{
                    changeSubmissionImage = true
                    showActionSheetCamera = true
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
                Spacer()
                    .frame(height: 10)
                
            }
            
            //Trip Name Form
            if tripNameValidation == true {
                if vm.title.isEmpty {
                    Group{
                        TripNameIncorrect
                        Spacer()
                            .frame(height: 10)
                    }
                }else {
                    Group{
                        TripNameCorrect
                        Spacer()
                            .frame(height: 10)
                    }
                }
            }
            else {
                Group{
                    TripNameCorrect
                    Spacer()
                        .frame(height: 10)
                }
            }
            //Trip Destination Form
            if destinationValidation == true {
                if vm.destination.isEmpty{
                    Group{
                        DestinationIncorrect
                        Spacer()
                            .frame(height: 10)
                    }
                }else {
                    Group{
                        DestinationCorrect
                        Spacer()
                            .frame(height: 10)
                        }
                    }
            }else {
                Group{
                   DestinationCorrect
                    Spacer()
                        .frame(height: 10)
                }
            }
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
                .background(deepblue)
                .foregroundColor(yellow)
                .cornerRadius(10)
                .onTapGesture {
                    //Function Save trip plan data + Move to Trip Page
                    createButtonPressed()
                }
            //            })
        }.padding(20)
        
    }
    
    private var TripStartDateIncorrect: some View{
        VStack{
            ZStack{
                Rectangle()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 1)
                        )
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
            Text("Start date is required")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("Gilroy-Light", size: 15))
                .foregroundColor(.red)
                .padding(.horizontal, 50)
        }
    }
    
    private var TripStartDateCorrect: some View {
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
                            .accentColor(deepblue)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .frame(height: 300)
                            .labelsHidden()
                            .padding(.horizontal, 50)
                        Spacer()
                    }
                }
                
            }else{
                if startDateValidation == true{
                    if valueStartDate == false {
                        TripStartDateIncorrect
                    }else{
                        TripStartDateCorrect
                     }
                }else{
                   TripStartDateCorrect
                }
            }
        }
    }
    
    private var TripEndDateIncorrect : some View{
        VStack{
            ZStack{
                Rectangle()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 1)
                        )
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
                        Text((valueEndDate ? "\(vm.endDate, formatter: CreatePlanView.stackDateFormat)" : "Set Start Date"))
                            .foregroundColor(valueEndDate ? .black : .gray)
                            .font(Font.custom("Gilroy-Light", size: 15))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .rotationEffect(.degrees(showEndDate ? 90 : 0))
                            .animation(.easeInOut(duration: 4), value: showEndDate)
                    })
                    Spacer()
                }.padding(.horizontal, 50)
            }
            Text("End date is required")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("Gilroy-Light", size: 15))
                .foregroundColor(.red)
                .padding(.horizontal, 50)
        }
    }
    
    private var TripEndDateCorrect: some View{
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
                    Text((valueEndDate ? "\(vm.endDate, formatter: CreatePlanView.stackDateFormat)" : "Set Start Date"))
                        .foregroundColor(valueEndDate ? .black : .gray)
                        .font(Font.custom("Gilroy-Light", size: 15))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(showEndDate ? 90 : 0))
                        .animation(.easeInOut(duration: 4), value: showEndDate)
                })
                Spacer()
            }.padding(.horizontal, 50)
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
                            .accentColor(deepblue)
                            .labelsHidden()
                            .padding(.horizontal, 50)
                        Spacer()
                    }
                }
                
            }else{
                if endDateValidation == true{
                    if valueEndDate == false{
                        TripEndDateIncorrect
                    }else{
                        TripEndDateCorrect
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
                                Text((valueEndDate ? "\(vm.endDate, formatter: CreatePlanView.stackDateFormat)" : "Set Start Date"))
                                    .foregroundColor(valueEndDate ? .black : .gray)
                                    .font(Font.custom("Gilroy-Light", size: 15))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .rotationEffect(.degrees(showEndDate ? 90 : 0))
                                    .animation(.easeInOut(duration: 4), value: showEndDate)
                            })
                            Spacer()
                        }.padding(.horizontal, 50)
                    }
                }
            }
        }
    }
 
    private var TripNameCorrect: some View {
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
    }
    
    private var TripNameIncorrect: some View {
        VStack{
            ZStack{
                Rectangle()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 1)
                        )
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
            Text("Trip Name is required")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("Gilroy-Light", size: 15))
                .foregroundColor(.red)
                .padding(.horizontal, 50)
        }
    }
    
    private var DestinationCorrect: some View {
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
                TextField("Trip Name", text: $vm.destination)
                    .frame(width: 250, alignment: .leading)
                    .font(Font.custom("Gilroy-Light", size: 15))
                    .foregroundColor(.black)
                Spacer()
            }.padding(.horizontal, 50)
        }
    }
    
    private var DestinationIncorrect: some View {
        VStack{
            ZStack{
                Rectangle()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 1)
                        )
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
            Text("Destination is Required")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("Gilroy-Light", size: 15))
                .foregroundColor(.red)
                .padding(.horizontal, 50)
        }
    }
}

//MARK: Function
extension CreatePlanView {
    func createButtonPressed() {
        
        if vm.title.isEmpty || vm.destination.isEmpty || vm.startDate.description.isEmpty || vm.endDate.description.isEmpty{
            tripNameValidation = true
            destinationValidation = true
            startDateValidation = true
            endDateValidation = true
        }
//        if vm.startDate.description.isEmpty || vm.endDate.description.isEmpty{
//            startDateValidation = true
//            endDateValidation = true
//        }
//        if vm.startDate.description.isEmpty { startDateValidation = true}
//        if vm.endDate.description.isEmpty{
//            endDateValidation = true
//        }
        else{
            if (!vm.title.isEmpty) || (!vm.destination.isEmpty) || (!vm.startDate.description.isEmpty) || (!vm.endDate.description.isEmpty){
            vm.addButtonPressed()
            presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
