//
//  ActivitesViewModel.swift
//  Trapple
//
//  Created by Vincent Leonard on 29/08/22.
//

import CloudKit
import Foundation

class ActivitiesViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var location: String = ""
    @Published var description: String = ""
    @Published var startDate: Date = .init()
    @Published var endDate: Date = .init()
    @Published var actualDate: Date = .init()
    @Published var activity: [ActivityViewModel] = []
    @Published var dates: [String] = []
    @Published var isOpen: [Bool] = []
    
    @Published var listTitle: [String] = []
    @Published var listLocation: [String] = []
    @Published var listDescription: [String] = []
    @Published var listStart: [String] = []
    @Published var listEnd: [String] = []
    @Published var isLoaded: Bool = false
    
    init() {
//        fetchItems()
    }
    
    func addButtonPressed(planID: CKRecord.ID, actualDate: String) {
        print("Activities Plan ID: \(planID)")
        guard !title.isEmpty else {return}
        guard !location.isEmpty else {return}
//        guard !description.isEmpty else {return}
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
        let convertedDate = dateFormatter.date(from: actualDate)
        newActivity["actualDate"] = convertedDate
        newActivity["planID"] = CKRecord.Reference(record: planDetail, action: .deleteSelf)
//        newActivity.setValuesForKeys(PlanModel(title: title, destination: destination, startDate: startDate, endDate: endDate).planDictionary())
        
//        listTitle.append(title)
//        listLocation.append(location)
//        listDescription.append(description)
//        listStart.append(stringStart)
//        listEnd.append(stringEnd)
        activity.removeAll()
        
        saveItem(planID: planID, actualDate: actualDate, record: newActivity)
    }
    
    private func saveItem(planID: CKRecord.ID, actualDate: String, record: CKRecord) {
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.fetchItems(planID: planID)
                print("Success fetch activity items")
            }
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let activitiesDelete = activity[index]
//        let recordID = plan.recordID!
        
        CKContainer.default().privateCloudDatabase.delete(withRecordID: activitiesDelete.recordID!) { [weak self] _, _ in
//            self?.activity.remove(at: index)
        }
//        fetchItems(planID: planID)
//        removeList(index: index)
    }
    
    func fetchItems(planID: CKRecord.ID) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMMM d"
//        let actualDate = dateFormatter.date(from: actualDate)
        
        let recordToMatch = CKRecord.Reference(recordID: planID, action: .deleteSelf)
//        let predicate = NSPredicate(format: "planID == %@", recordToMatch)
        let predicate = NSPredicate(format: "(planID == %@)", argumentArray: [recordToMatch, actualDate])
        let query = CKQuery(recordType: "Activities", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [ActivityModel] = []
        
        queryOperation.qualityOfService = .userInteractive
        
        // Query for saving fetched items in an array
        queryOperation.recordMatchedBlock = { _, returnedResult in
            switch returnedResult {
            case let .success(record):
//                guard let title = record["title"] as? String else {return}
                if let activityList = ActivityModel.fromRecord(record: record) {
                    returnedItems.append(activityList)
                    DispatchQueue.main.async {
                        if self.isLoaded == false {
                            self.addList(title: activityList.title, location: activityList.location, description: activityList.description, startDate: self.dateFormatter(date: activityList.startDate), endDate: self.dateFormatter(date: activityList.endDate))
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
                self?.activity = returnedItems.map(ActivityViewModel.init)
                
                self?.isLoaded = true
            }
        }
        
        addOperation(operation: queryOperation)
    }
    
//    func fetchItem(planID: CKRecord.ID) {
//        let recordToMatch = CKRecord.Reference(recordID: planID, action: .deleteSelf)
//        let predicate = NSPredicate(format: "planID == %@", recordToMatch)
//        let query = CKQuery(recordType: "Activities", predicate: predicate)
//        query.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
//        let queryOperation = CKQueryOperation(query: query)
//
//        var returnedItems: [ActivityModel] = []
//
//        queryOperation.qualityOfService = .userInteractive
//
//        // Query for saving fetched items in an array
//        queryOperation.recordMatchedBlock = { _, returnedResult in
//            switch returnedResult {
//            case let .success(record):
    ////                guard let title = record["title"] as? String else {return}
//                if let activityList = ActivityModel.fromRecord(record: record) {
//                    returnedItems.append(activityList)
//                }
//            case let .failure(error):
//                print("Error recordMatchedBlock: \(error)")
//            }
//        }
//
//        // Returned fetched items
//        queryOperation.queryResultBlock = { [weak self] returnedResult in
//            print("Returned Result: \(returnedResult)")
//            DispatchQueue.main.async {
//                self?.activity = returnedItems.map(ActivityViewModel.init)
//            }
//        }
//
//        print(returnedItems)
//
//        addOperation(operation: queryOperation)
//    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().privateCloudDatabase.add(operation)
    }
    
    func addList(title: String, location: String, description: String, startDate: String, endDate: String) {
        DispatchQueue.main.async {
            self.listTitle.append(title)
            self.listLocation.append(location)
            self.listDescription.append(description)
            self.listStart.append(startDate)
            self.listEnd.append(endDate)
        }
    }
    
    func removeList(index: Int) {
        DispatchQueue.main.async {
            self.listTitle.remove(at: index)
            self.listLocation.remove(at: index)
            self.listDescription.remove(at: index)
            self.listStart.remove(at: index)
            self.listEnd.remove(at: index)
        }
    }
    
    func resetList() {
        DispatchQueue.main.async {
            self.listTitle = []
            self.listLocation = []
            self.listDescription = []
            self.listStart = []
            self.listEnd = []
            self.isLoaded = false
        }
    }
    
    func getDates(startDate: Date, endDate: Date) {
        dates.removeAll()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMMM d"
        let startDatestring = dateFormatter.string(from: startDate)
        let startDates = dateFormatter.date(from: startDatestring)
        let endDatestring = dateFormatter.string(from: endDate)
        let endDates = dateFormatter.date(from: endDatestring)
        let dayDurationInSeconds: TimeInterval = 60*60*24
        for date in stride(from: startDates!, to: endDates!, by: dayDurationInSeconds) {
//            print(date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d"
            let dateAppend = dateFormatter.string(from: date)
            dates.append(dateAppend)
        }
        getFinalDate(endDate: endDates!)
    }
    
    func getFinalDate(endDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        let dateAppend = dateFormatter.string(from: endDate)
        dates.append(dateAppend)
        print(dates)
    }
    
    func getDateRange(startDate: Date, endDate: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMMM d"
        let startDatestring = dateFormatter.string(from: startDate)
        let startDates = dateFormatter.date(from: startDatestring)
        let endDatestring = dateFormatter.string(from: endDate)
        let endDates = dateFormatter.date(from: endDatestring)
        let dayDurationInSeconds: TimeInterval = 60*60*24
        var day = 1
        for date in stride(from: startDates!, to: endDates!, by: dayDurationInSeconds) {
            day += 1
        }
        return day
    }
    
    func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
}

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}

struct ActivityViewModel {
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
