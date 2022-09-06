//
//  ActivitesViewModel.swift
//  Trapple
//
//  Created by Vincent Leonard on 29/08/22.
//

import Foundation
import CloudKit

class ActivitiesViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var location: String = ""
    @Published var description: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var actualDate: Date = Date()
    @Published var activity: [ActivityViewModel] = []
    @Published var dates: [String] = []
    @Published var isOpen: [Bool] = []
    
    init() {
//        fetchItems()
    }
    
    func addButtonPressed(planID: CKRecord.ID, actualDate: String) {
        print("Activities Plan ID: \(planID)")
        guard !title.isEmpty else {return}
        guard !location.isEmpty else {return}
        guard !description.isEmpty else {return}
        addItem(planID: planID, title: title, location: location, description: description, startDate: startDate, endDate: endDate, actualDate: actualDate)
    }
    
    private func addItem(planID: CKRecord.ID, title: String, location: String, description: String, startDate: Date, endDate: Date, actualDate: String) {
        let newActivity = CKRecord(recordType: "Activities")
        let planDetail = CKRecord(recordType: "Plans", recordID: planID)
//        let reference = CKRecord.Reference(recordID: planDetail.recordID, action: .deleteSelf)
        newActivity["title"] = title
        newActivity["location"] = location
        newActivity["description"] = description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let stringStart = dateFormatter.string(from: startDate)
        let dateStart = dateFormatter.date(from: stringStart)
        newActivity["startDate"] = dateStart
        let stringEnd = dateFormatter.string(from: endDate)
        let dateEnd = dateFormatter.date(from: stringEnd)
        newActivity["endDate"] = dateEnd
        dateFormatter.dateFormat = "MMMM d"
        let actualDate = dateFormatter.date(from: actualDate)
        newActivity["actualDate"] = actualDate
        newActivity["planID"] = CKRecord.Reference(record: planDetail, action: .deleteSelf)
//        newActivity.setValuesForKeys(PlanModel(title: title, destination: destination, startDate: startDate, endDate: endDate).planDictionary())
        saveItem(record: newActivity)
    }
    
    private func saveItem(record: CKRecord) {
        CKContainer.default().privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
            DispatchQueue.main.async {
                self?.title = ""
                self?.location = ""
                self?.description = ""
                self?.startDate = Date()
                self?.endDate = Date()
                self?.actualDate = Date()
            }
        }
    }
    
    func fetchItems(planID: CKRecord.ID, actualDate: String) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        let actualDate = dateFormatter.date(from: actualDate)
        
        let recordToMatch = CKRecord.Reference(recordID: planID, action: .deleteSelf)
//        let predicate = NSPredicate(format: "planID == %@", recordToMatch)
        let predicate = NSPredicate(format: "(planID == %@) AND (actualDate == %@)", argumentArray: [recordToMatch, actualDate])
        let query = CKQuery(recordType: "Activities", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [ActivityModel] = []
        
        //Query for saving fetched items in an array
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case.success(let record):
//                guard let title = record["title"] as? String else {return}
                if let activityList = ActivityModel.fromRecord(record: record){
                    returnedItems.append(activityList)
                }
            case.failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
        
        //Returned fetched items
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Result: \(returnedResult)")
            DispatchQueue.main.async {
                self?.activity = returnedItems.map(ActivityViewModel.init)
            }
            
        }
        
        print(returnedItems)
        
        for _ in returnedItems {
            isOpen.append(false)
        }
        
        addOperation(operation: queryOperation)
        
    }
    
    func fetchItem(planID: CKRecord.ID) {
        
        let recordToMatch = CKRecord.Reference(recordID: planID, action: .deleteSelf)
        let predicate = NSPredicate(format: "planID == %@", recordToMatch)
        let query = CKQuery(recordType: "Activities", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [ActivityModel] = []
        
        //Query for saving fetched items in an array
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case.success(let record):
//                guard let title = record["title"] as? String else {return}
                if let activityList = ActivityModel.fromRecord(record: record){
                    returnedItems.append(activityList)
                }
            case.failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
        
        //Returned fetched items
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Result: \(returnedResult)")
            DispatchQueue.main.async {
                self?.activity = returnedItems.map(ActivityViewModel.init)
            }
            
        }
        
        print(returnedItems)
        
        addOperation(operation: queryOperation)
        
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().privateCloudDatabase.add(operation)
    }
    
    func getDates(startDate: Date, endDate: Date) {
        let dayDurationInSeconds: TimeInterval = 60*60*24
        for date in stride(from: startDate, to: endDate, by: dayDurationInSeconds) {
//            print(date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d"
            let dateAppend = dateFormatter.string(from: date)
            dates.append(dateAppend)
        }
        getFinalDate(endDate: endDate)
    }
    
    func getFinalDate(endDate: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        let dateAppend = dateFormatter.string(from: endDate)
        dates.append(dateAppend)
        print(dates)
    }
}

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}

struct ActivityViewModel{
    
    let activityList: ActivityModel
    
    var recordID: CKRecord.ID? {
        activityList.recordID
    }
    
    var title: String {
        activityList.title
    }
    
    var location: String {
        activityList.location
    }
    
    var description: String {
        activityList.description
    }
    
    var startDate: Date {
        activityList.startDate
    }
    
    var endDate: Date {
        activityList.endDate
    }
    
    var actualDate: Date {
        activityList.actualDate
    }
}

