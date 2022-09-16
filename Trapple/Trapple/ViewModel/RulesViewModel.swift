//
//  RulesViewModel.swift
//  Trapple
//
//  Created by Jonathan Kevin on 29/08/22.
//

import CloudKit
// import Foundation
// import Combine
import SwiftUI

class RulesViewModel: ObservableObject {
    @Published var listTitle: [String] = []
    @Published var listDescription: [String] = []
    @Published var listAdd: [Bool] = []
    @Published var listEdit: [Bool] = []
    @Published var rules: [RuleViewModel] = []
    @Published var isLoaded: Bool = false
    
    init() {
//        fetchItems()
    }
    
    func addButtonPressed(planID: CKRecord.ID, title: String, description: String) {
        print("Rule Plan ID: \(planID)")
        guard !title.isEmpty else { return }
//        guard !description.isEmpty else { return }
        addItem(planID: planID, title: title, description: description)
    }
    
    private func addItem(planID: CKRecord.ID, title: String, description: String) {
        let newRule = CKRecord(recordType: "Rules")
        let planDetail = CKRecord(recordType: "Plans", recordID: planID)
        newRule["title"] = title
        newRule["description"] = description
        newRule["planID"] = CKRecord.Reference(record: planDetail, action: .deleteSelf)
        saveItem(planID: planID, record: newRule)
    }
    
    private func saveItem(planID: CKRecord.ID, record: CKRecord) {
        CKContainer.default().privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
//            DispatchQueue.main.async {
//                self?.title = ""
//                self?.description = ""
//            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.fetchItems(planID: planID)
            }
        }
    }
    
    func updateItem(planID: CKRecord.ID, rule: RuleViewModel, title: String, description: String, index: IndexSet) {
        if title != "" {
            let record = rule.record
            record["title"] = title
            record["description"] = description
            saveItem(planID: planID, record: record)
        } else {
            deleteItem(indexSet: index)
        }
    }
    
//    func updateTitle(planID: CKRecord.ID, rule: RuleViewModel, title: String) {
//        let record = rule.record
//        record["title"] = title
//        saveItem(planID: planID, record: record)
//    }
//
//    func updateDescription(planID: CKRecord.ID, rule: RuleViewModel, description: String) {
//        let record = rule.record
//        record["description"] = description
//        saveItem(planID: planID, record: record)
//    }
        
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        if rules.count > index {
            let rule = rules[index]
//            let recordID = plan.recordID!
            
            CKContainer.default().privateCloudDatabase.delete(withRecordID: rule.recordID!) { [weak self] _, _ in
                self?.rules.remove(at: index)
//                self?.removeList(index: index)
            }
        }
            
        removeList(index: index)
    }
    
    func fetchItems(planID: CKRecord.ID) {
        let recordToMatch = CKRecord.Reference(recordID: planID, action: .deleteSelf)
        let predicate = NSPredicate(format: "planID == %@", recordToMatch)
        let query = CKQuery(recordType: "Rules", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [RuleModel] = []
        
        queryOperation.qualityOfService = .userInteractive
        
        // Query for saving fetched items in an array
        queryOperation.recordMatchedBlock = { _, returnedResult in
            switch returnedResult {
            case let .success(record):
//                guard let title = record["title"] as? String else {return}
                if let ruleList = RuleModel.fromRecord(record: record) {
                    returnedItems.append(ruleList)
                    DispatchQueue.main.async {
                        if self.isLoaded == false {
                            self.addList(title: ruleList.title, description: ruleList.description, isAdd: false, isEdit: false)
                        }
                    }
                }
                
            case let .failure(error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
        
        // Returned fetched items
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Result: \(returnedResult)")
            DispatchQueue.main.async {
                self?.rules = returnedItems.map(RuleViewModel.init)
                
                self?.isLoaded = true
//                print(self?.isLoaded)
            }
        }
        
        addOperation(operation: queryOperation)
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().privateCloudDatabase.add(operation)
    }
    
    func addList(title: String, description: String, isAdd: Bool, isEdit: Bool) {
        DispatchQueue.main.async {
            self.listTitle.append(title)
            self.listDescription.append(description)
            self.listAdd.append(isAdd)
            self.listEdit.append(isEdit)
        }
    }
    
    func removeList(index: Int) {
        DispatchQueue.main.async {
            self.listTitle.remove(at: index)
            self.listDescription.remove(at: index)
            self.listAdd.remove(at: index)
            self.listEdit.remove(at: index)
        }
    }
}

struct RuleViewModel {
    let ruleList: RuleModel
    
    var record: CKRecord {
        ruleList.record
    }
    
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
