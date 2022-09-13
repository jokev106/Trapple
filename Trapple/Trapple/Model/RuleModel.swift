//
//  RulesModel.swift
//  Trapple
//
//  Created by Jonathan Kevin on 29/08/22.
//

import Foundation
import CloudKit

struct RuleModel {
    
    let record: CKRecord
    var recordID: CKRecord.ID?
    let title: String
    let description: String
    
    init(record: CKRecord, recordID: CKRecord.ID? = nil, title: String, description: String) {
        self.record = record
        self.recordID = recordID
        self.title = title
        self.description = description
    }
    
    func ruleDictionary() ->[String: Any]{
        return ["title": title, "description": description]
    }
    
    static func fromRecord( record: CKRecord) -> RuleModel? {
        guard let title = record.value(forKey: "title") as? String , let description = record.value(forKey: "description") as? String
        else{
            return nil
        }
        
        return RuleModel(record: record.self, recordID: record.recordID, title: title, description: description)
    }
}

