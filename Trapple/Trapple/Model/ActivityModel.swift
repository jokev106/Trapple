//
//  ActivityModel.swift
//  Trapple
//
//  Created by Vincent Leonard on 29/08/22.
//

import Foundation
import CloudKit

struct ActivityModel {
    
    var recordID: CKRecord.ID?
    let title: String
    let location: String
    let description: String
    let startDate: Date
    let endDate: Date
    
    init(recordID: CKRecord.ID? = nil, title: String, location: String, description: String, startDate: Date, endDate: Date) {
        self.recordID = recordID
        self.title = title
        self.location = location
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func activityDictionary() ->[String: Any]{
        return ["title": title, "location": location, "description": description, "startDate": startDate, "endDate": endDate]
    }
    
    static func fromRecord( record: CKRecord) -> ActivityModel? {
        guard let title = record.value(forKey: "title") as? String , let location = record.value(forKey: "location") as? String , let description = record.value(forKey: "description") as? String , let startDate = record.value(forKey: "startDate") as? Date , let endDate = record.value(forKey: "endDate") as? Date
        else{
            return nil
        }
        
        return ActivityModel(recordID: record.recordID, title: title, location: location, description: description, startDate: startDate, endDate: endDate)
    }
}
