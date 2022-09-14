//
//  MyProfileView.swift
//  Trapple
//
//  Created by Jonathan Kevin on 26/08/22.
//

import SwiftUI
import CloudKit

struct MyProfileView: View {
    
    @StateObject private var vm = PlansViewModel()
    @ObservedObject var CKvm: CloudKitViewModel
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                NavigationView{
                    VStack{
                        //Content
                        //User Data Section (TOP)
                        UserDataSection
                        Spacer()
                            .frame(height: 20)
                        Divider
                        //History User Trip
                        Spacer()
                            .frame(height: 10)
                        HistoryUserSection
                        
                    }.navigationTitle("My Profile")
                        .background(graybg)
                }
            }
        }
    }
}

//struct MyProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyProfileView()
//    }
//}

//MARK: Components
extension MyProfileView {
    
    private var Divider: some View{
        SwiftUI.Divider()
            .padding(.horizontal)
    }
    
    private var UserDataSection: some View{
        VStack{
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(deepblue)
                .padding(.top)
            Spacer()
                .frame(height: 10)
            ZStack{
                VStack{
                    Text(CKvm.userName)
                        .frame(maxWidth: .infinity, alignment: .center)
                .font(Font.custom("Gilroy-ExtraBold", size: 20))
                .padding(.top, 0.5)
                .foregroundColor(deepblue)
                    
                }
            }
        }
    }
    
    private var HistoryUserSection: some View{
        VStack{
            Text("My History").bold()
                .frame(width: 350, alignment: .leading)
                .foregroundColor(blacktext)
                .font(Font.custom("Gilroy-Light", size: 20))
                .padding(0.5)
            ScrollView{
                VStack{
                    ForEach(vm.plans, id: \.recordID) { items in
                        TripCardView(vm: vm, planRecord: items, plan: items.title, destination: items.destination, startDate: items.startDate, endDate: items.endDate, planID: items.recordID!, categoryDefault: items.categoryDefault, planImage: items.imageURL)
                                .padding(.bottom, 20)
                                .padding(.trailing, 30)
                                .padding(.leading, 30)
                    }
                }
            }
        }.onAppear{
            vm.fetchHistory()
        }
    }
    
}

//MARK: Function
