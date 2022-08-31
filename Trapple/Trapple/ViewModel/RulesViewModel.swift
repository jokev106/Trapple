//
//  RulesViewModel.swift
//  Trapple
//
//  Created by Jonathan Kevin on 29/08/22.
//

//import Foundation
//import Combine
import SwiftUI
import CloudKit

//class RulesViewModel: ObservableObject {
//    @Published var inputRules : String = ""
//    @Published var inputShortDesc : String = ""
//    @Published var rulesID : [RulesModel] = []
//
//    func onAdd(rules: String, shortdesc: String) {
//        rulesID.append(RulesModel(rules: inputRules, shortdesc: inputShortDesc ))
//        self.inputRules = ""
//        self.inputShortDesc = ""
//    }
//
//    func onDelete(offset: IndexSet) {
//        rulesID.remove(atOffsets: offset)
//    }
//
//    func onMove(source: IndexSet, destination: Int){
//        rulesID.move(fromOffsets: source, toOffset: destination)
//    }
//
//    func onUpdate(index: Int, inputRules: String, inputShortDesc: String) {
//        rulesID[index].rules = inputRules
//        rulesID[index].shortdesc = inputShortDesc
//    }
//}

class RulesViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var rules: [RuleViewModel] = []
    
    init() {
//        fetchItems()
    }
    
    func addButtonPressed(planID: CKRecord.ID) {
        print("Rule Plan ID: \(planID)")
        guard !title.isEmpty else {return}
        guard !description.isEmpty else {return}
        addItem(planID: planID, title: title, description: description)
    }
    
    private func addItem(planID: CKRecord.ID, title: String, description: String) {
        let newRule = CKRecord(recordType: "Rules")
        let planDetail = CKRecord(recordType: "Plans", recordID: planID)
        newRule["title"] = title
        newRule["description"] = description
        newRule["planID"] = CKRecord.Reference(record: planDetail, action: .deleteSelf)
        saveItem(record: newRule)
    }
    
    private func saveItem(record: CKRecord) {
        CKContainer.default().privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
            DispatchQueue.main.async {
                self?.title = ""
                self?.description = ""
            }
        }
    }
    
    func deleteItem(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let rule = rules[index]
//        let recordID = plan.recordID!
        
        CKContainer.default().privateCloudDatabase.delete(withRecordID: rule.recordID!) { [weak self] returnedRecordID, ReturnedError in
            self?.rules.remove(at: index)
        }
    }
    
    func fetchItems(planID: CKRecord.ID) {
        
        let recordToMatch = CKRecord.Reference(recordID: planID, action: .deleteSelf)
        let predicate = NSPredicate(format: "planID == %@", recordToMatch)
        let query = CKQuery(recordType: "Rules", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [RuleModel] = []
        
        //Query for saving fetched items in an array
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case.success(let record):
//                guard let title = record["title"] as? String else {return}
                if let ruleList = RuleModel.fromRecord(record: record){
                    returnedItems.append(ruleList)
                }
            case.failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
        
        //Returned fetched items
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Result: \(returnedResult)")
            DispatchQueue.main.async {
                self?.rules = returnedItems.map(RuleViewModel.init)
            }
            
        }
        
        addOperation(operation: queryOperation)
        
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().privateCloudDatabase.add(operation)
    }
}

struct RuleViewModel{
    
    let ruleList: RuleModel
    
    var recordID: CKRecord.ID? {
        ruleList.recordID
    }
    
    var title: String {
        ruleList.title
    }
    
    var description: String {
        ruleList.description
    }
}
