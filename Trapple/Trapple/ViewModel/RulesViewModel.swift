//
//  RulesViewModel.swift
//  Trapple
//
//  Created by Jonathan Kevin on 29/08/22.
//

import Foundation
import Combine
import SwiftUI

class RulesViewModel: ObservableObject {
    @Published var inputRules : String = ""
    @Published var inputShortDesc : String = ""
    @Published var rulesID : [RulesModel] = []
    
    func onAdd(rules: String, shortdesc: String) {
        rulesID.append(RulesModel(rules: inputRules, shortdesc: inputShortDesc ))
        self.inputRules = ""
        self.inputShortDesc = ""
    }
    
    func onDelete(offset: IndexSet) {
        rulesID.remove(atOffsets: offset)
    }
    
    func onMove(source: IndexSet, destination: Int){
        rulesID.move(fromOffsets: source, toOffset: destination)
    }
 
    func onUpdate(index: Int, inputRules: String, inputShortDesc: String) {
        rulesID[index].rules = inputRules
        rulesID[index].shortdesc = inputShortDesc
    }
}
