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
    @Published var history: Int64 = 0
    @Published var categoryDefault: Int64 = 0
    @Published var planImage: URL?
    @Published var plans: [PlanViewModel] = []
    
    init() {
        fetchItems()
    }
    
    func addButtonPressed(savedImage: UIImage) {
        guard !title.isEmpty else {return}
        guard !destination.isEmpty else {return}
        addItem(title: title, destination: destination, startDate: startDate, endDate: endDate, savedImage: savedImage)
    }
    
    private func addItem(title: String, destination: String, startDate: Date, endDate: Date, savedImage: UIImage) {
        let newPlan = CKRecord(recordType: "Plans")
        newPlan["title"] = title
        newPlan["destination"] = destination
        newPlan["startDate"] = startDate
        newPlan["endDate"] = endDate
        newPlan["isHistory"] = 0
        newPlan["categoryDefault"] = 0
//        saveItem(record: newPlan)
        
        guard
//            let image = UIImage(named: "logo"),
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("planImage2.jpg"),
            let data = savedImage.jpegData(compressionQuality: 1.0)
        else {return}
        do {
            try data.write(to: url)
            let asset = CKAsset(fileURL: url)
            newPlan["image"] = asset
            saveItem(record: newPlan)
        } catch let error {
            print(error)
        }
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self?.fetchItems()
                }
            }
        }
        
    }
    
    func updateHistory(plan: PlanViewModel) {
        let record = plan.record
        record["isHistory"] = 1
        saveItem(record: record)
    }
    
    func updateCategory(plan: PlanViewModel) {
        let record = plan.record
        record["categoryDefault"] = 1
        saveItem(record: record)
    }

    
    func deleteItem(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let plan = plans[index]
//        let recordID = plan.recordID!
        
        CKContainer.default().privateCloudDatabase.delete(withRecordID: plan.recordID!) { [weak self] returnedRecordID, ReturnedError in
            self?.plans.remove(at: index)
        }
    }
    
    func fetchItems() {
        
//        let predicate = NSPredicate(value: true)
        let falseNumber:NSNumber = 0
        let predicate = NSPredicate(format: "isHistory = %@", falseNumber)
        let query = CKQuery(recordType: "Plans", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [PlanModel] = []
        
        //Query for saving fetched items in an array
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case.success(let record):
//                guard let title = record["title"] as? String else {return}
                if let planList = PlanModel.fromRecord(record: record){
//                    let imageAsset = record["image"] as? CKAsset
//                    let imageURL = imageAsset?.fileURL
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
    
    func fetchHistory() {
        
//        let predicate = NSPredicate(value: true)
        let trueNumber:NSNumber = 1
        let predicate = NSPredicate(format: "isHistory == %@", trueNumber)
        let query = CKQuery(recordType: "Plans", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [PlanModel] = []
        
        //Query for saving fetched items in an array
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case.success(let record):
//                guard let title = record["title"] as? String else {return}
                if let planList = PlanModel.fromRecord(record: record){
//                    let imageAsset = record["image"] as? CKAsset
//                    let imageURL = imageAsset?.fileURL
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
    
    func getDateRange(startDate: Date, endDate: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMMM d"
        let startDatestring = dateFormatter.string(from: startDate)
        let startDates = dateFormatter.date(from: startDatestring)
        let endDatestring = dateFormatter.string(from: endDate)
        let endDates = dateFormatter.date(from: endDatestring)
        let dayDurationInSeconds: TimeInterval = 60*60*24
        var day: Int = 1
        for date in stride(from: startDates!, to: endDates!, by: dayDurationInSeconds) {
            day += 1
        }
        return day
    }
}

struct PlanViewModel{
    
    let planList: PlanModel
    
    var record: CKRecord {
        planList.record
    }
    
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
    
    var isHistory: Int64 {
        planList.isHistory
    }
    
    var categoryDefault: Int64 {
        planList.categoryDefault
    }
    
    var planImage: CKAsset {
        planList.planImage
    }
    
    var imageURL: URL {
        planList.imageURL
    }
    
//    var imageURL: URL {
//        planList.imageURL
//    }
}
