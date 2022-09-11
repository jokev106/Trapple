//
//  PlanModel.swift
//  Trapple
//
//  Created by Vincent Leonard on 28/08/22.
//

import Foundation
import CloudKit

struct PlanModel {
    
    let record: CKRecord
    var recordID: CKRecord.ID?
    let title: String
    let destination: String
    let startDate: Date
    let endDate: Date
    let isHistory: Int64
    
    init(record: CKRecord, recordID: CKRecord.ID? = nil, title: String, destination: String, startDate: Date, endDate: Date, isHistory: Int64) {
        self.record = record
        self.recordID = recordID
        self.title = title
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.isHistory = isHistory
    }
    
    func planDictionary() ->[String: Any]{
        return ["title": title, "destination": destination, "startDate": startDate, "endDate": endDate, "isHistory": isHistory]
    }
    
    static func fromRecord( record: CKRecord) -> PlanModel? {
        guard let title = record.value(forKey: "title") as? String , let destination = record.value(forKey: "destination") as? String , let startDate = record.value(forKey: "startDate") as? Date , let endDate = record.value(forKey: "endDate") as? Date, let isHistory = record.value(forKey: "isHistory") as? Int64
        else{
            return nil
        }
        
        return PlanModel(record: record.self, recordID: record.recordID, title: title, destination: destination, startDate: startDate, endDate: endDate, isHistory: isHistory)
    }
}
