//
//  CategoryModel.swift
//  Trapple
//
//  Created by Vincent Leonard on 31/08/22.
//

import Foundation
import CloudKit

struct CategoryModel {
    
    var recordID: CKRecord.ID?
    let category: String
    let icon: String
    
    init(recordID: CKRecord.ID? = nil, category: String, icon: String) {
        self.recordID = recordID
        self.category = category
        self.icon = icon
    }
    
    func activityDictionary() ->[String: Any]{
        return ["category": category, "icon": icon]
    }
    
    static func fromRecord( record: CKRecord) -> CategoryModel? {
        guard let category = record.value(forKey: "category") as? String , let icon = record.value(forKey: "icon") as? String
        else{
            return nil
        }
        
        return CategoryModel(recordID: record.recordID, category: category, icon: icon)
    }
}
