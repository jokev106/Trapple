//
//  EquipmentModel.swift
//  Trapple
//
//  Created by Vincent Leonard on 31/08/22.
//

import Foundation
import CloudKit

struct EquipmentModel {
    
    var recordID: CKRecord.ID?
    let itemName: String
    let description: String
    let category: String
    let icon: String
    let equipmentImage: CKAsset
    let imageURL: URL
    
    init(recordID: CKRecord.ID? = nil, itemName: String, description: String, category: String, icon: String, equipmentImage: CKAsset, imageURL: URL) {
        self.recordID = recordID
        self.itemName = itemName
        self.description = description
        self.category = category
        self.icon = icon
        self.equipmentImage = equipmentImage
        self.imageURL = imageURL
    }
    
    func activityDictionary() ->[String: Any]{
        return ["itemName": itemName, "description": description, "category": category, "icon": icon, "image": imageURL]
    }
    
    static func fromRecord( record: CKRecord) -> EquipmentModel? {
        guard let itemName = record.value(forKey: "itemName") as? String , let description = record.value(forKey: "description") as? String , let category = record.value(forKey: "category") as? String , let icon = record.value(forKey: "icon") as? String, let equipmentImage = record.value(forKey: "image") as? CKAsset, let imageURL = equipmentImage.fileURL
        else{
            return nil
        }
        
        return EquipmentModel(recordID: record.recordID, itemName: itemName, description: description, category: category, icon: icon, equipmentImage: equipmentImage, imageURL: imageURL)
    }
}
