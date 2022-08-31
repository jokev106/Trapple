//
//  CloudkitTesting.swift
//  Trapple
//
//  Created by Vincent Leonard on 25/08/22.
//

import SwiftUI
import CloudKit

struct CloudKitTesting: View{
    
    @StateObject private var vm = CloudKitViewModel()
    
    var body: some View{
        NavigationView{
            VStack{
                Text("Is Signed In: \(vm.isSignedInToiCloud.description.uppercased())")
                Text(vm.error)
                Text("Permission: \(vm.permissionStatus.description.uppercased())")
                Text("Name: \(vm.userName)")
                NavigationLink("Next", destination: CloudKitCRUD())
            }
        }
        
    }
}

struct CloudKitTesting_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitTesting()
    }
}
