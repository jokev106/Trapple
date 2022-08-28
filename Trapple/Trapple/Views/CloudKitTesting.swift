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
        VStack{
            Text("Is Signed In: \(vm.isSignedInToiCloud.description.uppercased())")
            Text(vm.error)
            Text("Permission: \(vm.permissionStatus.description.uppercased())")
            Text("Name: \(vm.userName)")
        }
    }
}

struct CloudKitTesting_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitTesting()
    }
}
