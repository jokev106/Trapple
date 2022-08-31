//
//  EquipmentsViewModel.swift
//  Trapple
//
//  Created by Vincent Leonard on 31/08/22.
//

import Foundation
import CloudKit

class EquipmentsViewModel: ObservableObject {
    
    @Published var itemName: String = ""
    @Published var description: String = ""
    @Published var category: String = ""
    @Published var icon: String = ""
    @Published var equipment: [EquipmentViewModel] = []
    
    init() {
//        fetchItems()
    }
    
    func addButtonPressed(planID: CKRecord.ID, category: String, icon: String) {
        print("Equipments Plan ID: \(planID)")
        guard !itemName.isEmpty else {return}
        guard !description.isEmpty else {return}
        guard !category.isEmpty else {return}
        guard !icon.isEmpty else {return}
        addItem(planID: planID, itemName: itemName, description: description, category: category, icon: icon)
    }
    
    private func addItem(planID: CKRecord.ID, itemName: String, description: String, category: String, icon: String) {
        let newEquipment = CKRecord(recordType: "Items")
        let planDetail = CKRecord(recordType: "Plans", recordID: planID)
        newEquipment["itemName"] = itemName
        newEquipment["description"] = description
        newEquipment["category"] = category
        newEquipment["icon"] = icon
        newEquipment["planID"] = CKRecord.Reference(record: planDetail, action: .deleteSelf)
        saveItem(record: newEquipment)
    }
    
    private func saveItem(record: CKRecord) {
        CKContainer.default().privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
            DispatchQueue.main.async {
                self?.itemName = ""
                self?.description = ""
                self?.category = ""
                self?.icon = ""
            }
        }
    }
    
    func fetchItems(planID: CKRecord.ID, category: String) {
        
        let recordToMatch = CKRecord.Reference(recordID: planID, action: .deleteSelf)
        let predicate = NSPredicate(format: "(planID == %@) AND (category == %@)", argumentArray: [recordToMatch, category])
//        let predicate2 = NSPredicate(format: "category == %@", argumentArray: [category])
        let query = CKQuery(recordType: "Items", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [EquipmentModel] = []
        
        //Query for saving fetched items in an array
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case.success(let record):
//                guard let title = record["title"] as? String else {return}
                if let equipmentList = EquipmentModel.fromRecord(record: record){
                    returnedItems.append(equipmentList)
                }
            case.failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
        
        //Returned fetched items
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Result: \(returnedResult)")
            DispatchQueue.main.async {
                self?.equipment = returnedItems.map(EquipmentViewModel.init)
            }
            
        }
        
        addOperation(operation: queryOperation)
        
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().privateCloudDatabase.add(operation)
    }
}

struct EquipmentViewModel{
    
    let equipmentList: EquipmentModel
    
    var recordID: CKRecord.ID? {
        equipmentList.recordID
    }
    
    var itemName: String {
        equipmentList.itemName
    }
    
    var description: String {
        equipmentList.description
    }
    
    var category: String {
        equipmentList.category
    }
    
    var icon: String {
        equipmentList.icon
    }
}
