//
//  PlanModel.swift
//  Trapple
//
//  Created by Vincent Leonard on 28/08/22.
//

import Foundation
import CloudKit
import UIKit

struct PlanModel {
    
    let record: CKRecord
    var recordID: CKRecord.ID?
    let title: String
    let destination: String
    let startDate: Date
    let endDate: Date
    let isHistory: Int64
    let categoryDefault: Int64
    let planImage: CKAsset
    let imageURL: URL
    
    init(record: CKRecord, recordID: CKRecord.ID? = nil, title: String, destination: String, startDate: Date, endDate: Date, isHistory: Int64, categoryDefault: Int64, planImage: CKAsset, imageURL: URL) {
        self.record = record
        self.recordID = recordID
        self.title = title
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.isHistory = isHistory
        self.categoryDefault = categoryDefault
        self.planImage = planImage
        self.imageURL = imageURL
    }
    
    func planDictionary() ->[String: Any]{
        return ["title": title, "destination": destination, "startDate": startDate, "endDate": endDate, "isHistory": isHistory, "categoryDefault": categoryDefault, "image": imageURL]
    }
    
    static func fromRecord( record: CKRecord) -> PlanModel? {
        guard let title = record.value(forKey: "title") as? String , let destination = record.value(forKey: "destination") as? String , let startDate = record.value(forKey: "startDate") as? Date , let endDate = record.value(forKey: "endDate") as? Date, let isHistory = record.value(forKey: "isHistory") as? Int64, let categoryDefault = record.value(forKey: "categoryDefault") as? Int64, let planImage = record.value(forKey: "image") as? CKAsset, let imageURL = planImage.fileURL
        else{
            return nil
        }
        
        return PlanModel(record: record.self, recordID: record.recordID, title: title, destination: destination, startDate: startDate, endDate: endDate, isHistory: isHistory, categoryDefault: categoryDefault, planImage: planImage, imageURL: imageURL)
    }
}
