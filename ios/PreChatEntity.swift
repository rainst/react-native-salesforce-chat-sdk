//
//  PreChatEntity.swift
//  React-native-salesforce-chat-sdk
//
//  Created by Alex on 14/3/2023.
//

import Foundation
class PreChatEntity {
    struct EntityFieldMap {
        var doCreate: Bool
        var doFind: Bool
        var fieldName: String
        var isExactMatch: Bool
        var label: String
    }
    var linkToEntityField: String
    var linkToEntityName : String
    var saveToTranscript : String
    var entityFieldMaps: [EntityFieldMap]
    var entityName: String
    
    init?(dictionary: NSDictionary) {
        
        let linkToEntityField = dictionary["linkToEntityField"] as? String ?? ""
        let linkToEntityName = dictionary["linkToEntityName"] as? String ?? ""
        let saveToTranscript = dictionary["saveToTranscript"] as? String ?? ""
        guard let entityName = dictionary["entityName"] as? String,
              let entityFieldMapDictionaries = dictionary["entityFieldMaps"] as? [NSDictionary] else {
            return nil
        }
        
        var entityFieldMaps = [EntityFieldMap]()
        for entityFieldMapDictionary in entityFieldMapDictionaries {
            guard let doCreate = entityFieldMapDictionary["doCreate"] as? Bool,
                  let doFind = entityFieldMapDictionary["doFind"] as? Bool,
                  let fieldName = entityFieldMapDictionary["fieldName"] as? String,
                  let isExactMatch = entityFieldMapDictionary["isExactMatch"] as? Bool,
                  let label = entityFieldMapDictionary["label"] as? String else {
                continue
            }
            let entityFieldMap = EntityFieldMap(doCreate: doCreate, doFind: doFind, fieldName: fieldName, isExactMatch: isExactMatch, label: label)
            entityFieldMaps.append(entityFieldMap)
        }
        
        self.entityFieldMaps = entityFieldMaps
        self.entityName = entityName
        self.linkToEntityField = linkToEntityField
        self.linkToEntityName = linkToEntityName
        self.saveToTranscript = saveToTranscript
    }
}
