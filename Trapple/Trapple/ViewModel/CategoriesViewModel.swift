//
//  CategoryViewModel.swift
//  Trapple
//
//  Created by Vincent Leonard on 31/08/22.
//

import Foundation
import CloudKit

class CategoriesViewModel: ObservableObject {
    
    @Published var category: String = ""
    @Published var icon: String = ""
    @Published var categoryVM: [CategoryViewModel] = []
    
    init() {
//        fetchItems()
    }
    
    func addButtonPressed(planID: CKRecord.ID, category: String, icon: String) {
        print("Categories Plan ID: \(planID)")
        guard !category.isEmpty else {return}
        guard !icon.isEmpty else {return}
        addItem(planID: planID, category: category, icon: icon)
    }
    
    private func addItem(planID: CKRecord.ID, category: String, icon: String) {
        let newCategory = CKRecord(recordType: "Categories")
        let planDetail = CKRecord(recordType: "Plans", recordID: planID)
        newCategory["category"] = category
        newCategory["icon"] = icon
        newCategory["planID"] = CKRecord.Reference(record: planDetail, action: .deleteSelf)
        saveItem(planID: planID, record: newCategory)
    }
    
    private func saveItem(planID: CKRecord.ID, record: CKRecord) {
        CKContainer.default().privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
            DispatchQueue.main.async {
                self?.category = ""
                self?.icon = ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self?.fetchItems(planID: planID)
                }
            }
        }
    }
    
    func deleteItem(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let categoryDelete = categoryVM[index]
//        let recordID = plan.recordID!
        
        CKContainer.default().privateCloudDatabase.delete(withRecordID: categoryDelete.recordID!) { [weak self] returnedRecordID, ReturnedError in
            self?.categoryVM.remove(at: index)
        }
    }
    
    func fetchItems(planID: CKRecord.ID) {
        
        let recordToMatch = CKRecord.Reference(recordID: planID, action: .deleteSelf)
        let predicate = NSPredicate(format: "planID == %@", recordToMatch)
        let query = CKQuery(recordType: "Categories", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [CategoryModel] = []
        
        //Query for saving fetched items in an array
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case.success(let record):
//                guard let title = record["title"] as? String else {return}
                if let categoryList = CategoryModel.fromRecord(record: record){
                    returnedItems.append(categoryList)
                }
            case.failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
        
        //Returned fetched items
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Result: \(returnedResult)")
            DispatchQueue.main.async {
                self?.categoryVM = returnedItems.map(CategoryViewModel.init)
            }
            
        }
        
        addOperation(operation: queryOperation)
        
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().privateCloudDatabase.add(operation)
    }
}

struct CategoryViewModel{
    
    let categoryList: CategoryModel
    
    var recordID: CKRecord.ID? {
        categoryList.recordID
    }
    
    var category: String {
        categoryList.category
    }
    
    var icon: String {
        categoryList.icon
    }
}
