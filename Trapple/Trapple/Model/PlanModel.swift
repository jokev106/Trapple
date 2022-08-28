//
//  PlanModel.swift
//  Trapple
//
//  Created by Vincent Leonard on 28/08/22.
//

import Foundation
import CloudKit

struct PlanModel {
    
    var recordID: CKRecord.ID?
    let title: String
    let destination: String
    let startDate: Date
    let endDate: Date
    
    init(recordID: CKRecord.ID? = nil, title: String, destination: String, startDate: Date, endDate: Date) {
        self.title = title
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func planDictionary() ->[String: Any]{
        return ["title": title, "destination": destination, "startDate": startDate, "endDate": endDate]
    }
    
    static func fromRecord( record: CKRecord) -> PlanModel? {
        guard let title = record.value(forKey: "title") as? String , let destination = record.value(forKey: "destination") as? String , let startDate = record.value(forKey: "startDate") as? Date , let endDate = record.value(forKey: "endDate") as? Date
        else{
            return nil
        }
        
        return PlanModel(recordID: record.recordID, title: title, destination: destination, startDate: startDate, endDate: endDate)
    }
}
