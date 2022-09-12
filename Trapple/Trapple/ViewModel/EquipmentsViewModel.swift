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
    
    func addButtonPressed(categoryID: CKRecord.ID, category: String, icon: String) {
        print("Equipments Category ID: \(categoryID)")
        guard !itemName.isEmpty else {return}
        guard !description.isEmpty else {return}
        guard !category.isEmpty else {return}
        guard !icon.isEmpty else {return}
        addItem(categoryID: categoryID, itemName: itemName, description: description, category: category, icon: icon)
    }
    
    private func addItem(categoryID: CKRecord.ID, itemName: String, description: String, category: String, icon: String) {
        let newEquipment = CKRecord(recordType: "Items")
        let categoryDetail = CKRecord(recordType: "Categories", recordID: categoryID)
        newEquipment["itemName"] = itemName
        newEquipment["description"] = description
        newEquipment["category"] = category
        newEquipment["icon"] = icon
        newEquipment["categoryID"] = CKRecord.Reference(record: categoryDetail, action: .deleteSelf)
        saveItem(categoryID: categoryID, category: category, record: newEquipment)
    }
    
    private func saveItem(categoryID: CKRecord.ID, category: String, record: CKRecord) {
        CKContainer.default().privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
            DispatchQueue.main.async {
                self?.itemName = ""
                self?.description = ""
                self?.category = ""
                self?.icon = ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self?.fetchItems(categoryID: categoryID, category: category)
                }
            }
        }
    }
    
    func deleteItem(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let item = equipment[index]
//        let recordID = plan.recordID!
        
        CKContainer.default().privateCloudDatabase.delete(withRecordID: item.recordID!) { [weak self] returnedRecordID, ReturnedError in
            self?.equipment.remove(at: index)
        }
    }
    
    func fetchItems(categoryID: CKRecord.ID, category: String) {
        
        let recordToMatch = CKRecord.Reference(recordID: categoryID, action: .deleteSelf)
        let predicate = NSPredicate(format: "(categoryID == %@) AND (category == %@)", argumentArray: [recordToMatch, category])
//        let predicate2 = NSPredicate(format: "category == %@", argumentArray: [category])
        let query = CKQuery(recordType: "Items", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
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
