//
//  CloudKitCRUDViewModel.swift
//  Trapple
//
//  Created by Vincent Leonard on 26/08/22.
//

import SwiftUI
import CloudKit

class PlansViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var destination: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var plans: [PlanViewModel] = []
    
    init() {
        fetchItems()
    }
    
    func addButtonPressed() {
        guard !title.isEmpty else {return}
        guard !destination.isEmpty else {return}
        addItem(title: title, destination: destination, startDate: startDate, endDate: endDate)
    }
    
    private func addItem(title: String, destination: String, startDate: Date, endDate: Date) {
        let newPlan = CKRecord(recordType: "Plans")
        newPlan["title"] = title
        newPlan["destination"] = destination
        newPlan["startDate"] = startDate
        newPlan["endDate"] = endDate
//        newPlan.setValuesForKeys(PlanModel(title: title, destination: destination, startDate: startDate, endDate: endDate).planDictionary())
        saveItem(record: newPlan)
    }
    
    private func saveItem(record: CKRecord) {
        CKContainer.default().privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
            DispatchQueue.main.async {
                self?.title = ""
                self?.destination = ""
                self?.startDate = Date()
                self?.endDate = Date()
            }
        }
    }
    
    func fetchItems() {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Plans", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [PlanModel] = []
        
        //Query for saving fetched items in an array
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case.success(let record):
//                guard let title = record["title"] as? String else {return}
                if let planList = PlanModel.fromRecord(record: record){
                    returnedItems.append(planList)
                }
            case.failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
        
        //Returned fetched items
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Result: \(returnedResult)")
            DispatchQueue.main.async {
                self?.plans = returnedItems.map(PlanViewModel.init)
            }
            
        }
        
        addOperation(operation: queryOperation)
        
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().privateCloudDatabase.add(operation)
    }
}

struct PlanViewModel{
    
    let planList: PlanModel
    
    var recordID: CKRecord.ID? {
        planList.recordID
    }
    
    var title: String {
        planList.title
    }
    
    var destination: String {
        planList.destination
    }
    
    var startDate: Date {
        planList.startDate
    }
    
    var endDate: Date {
        planList.endDate
    }
}
