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
    let imageURL: URL
    
    init(recordID: CKRecord.ID? = nil, title: String, destination: String, startDate: Date, endDate: Date, imageURL: URL) {
        self.recordID = recordID
        self.title = title
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.imageURL = imageURL
    }
    
    func planDictionary() ->[String: Any]{
        return ["title": title, "destination": destination, "startDate": startDate, "endDate": endDate]
    }
    
    static func fromRecord( record: CKRecord) -> PlanModel? {
        guard let title = record.value(forKey: "title") as? String , let destination = record.value(forKey: "destination") as? String , let startDate = record.value(forKey: "startDate") as? Date , let endDate = record.value(forKey: "endDate") as? Date, let imageURL = record.value(forKey: "image") as? CKAsset, let imageAsset = imageURL.fileURL
        else{
            return nil
        }
        
        return PlanModel(recordID: record.recordID, title: title, destination: destination, startDate: startDate, endDate: endDate, imageURL: imageAsset)
    }
}
