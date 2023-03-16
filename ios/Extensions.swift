//
//  Extension.swift
//  React-native-salesforce-chat-sdk
//
//  Created by Alex on 14/3/2023.
//

import Foundation
import ServiceChat
extension SalesforceChatSdk{
    func createPreChatEntity(prechatEntity:PreChatEntity)-> SCSPrechatEntity{
        let data = SCSPrechatEntity(entityName: prechatEntity.entityName)
        data.linkToEntityName = prechatEntity.linkToEntityName
        data.linkToEntityField = prechatEntity.linkToEntityField
        data.saveToTranscript = prechatEntity.saveToTranscript
        for fieldMap in  prechatEntity.entityFieldMaps{
            print(fieldMap)
            let field = SCSPrechatEntityField(fieldName: fieldMap.fieldName, label: fieldMap.label)
            field.isExactMatch = fieldMap.isExactMatch
            field.doFind = fieldMap.doFind
            field.doCreate = fieldMap.doCreate
            
            data.entityFieldsMaps.add(field)
        }
       
        return data
    }
    func createPreChatField(preChatData:PreChatField)-> SCSPrechatObject{
        let data = SCSPrechatObject(label: preChatData.label, value: preChatData.initialValue)
        return data
    }
    func createPreChatTextInputField(preChatData:PreChatField)-> SCSPrechatTextInputObject{
        let data = SCSPrechatTextInputObject(label: preChatData.label)
		data?.label = preChatData.label
        data?.initialValue = preChatData.initialValue
        data?.autocapitalizationType = preChatData.autocapitalizationType
        data?.autocorrectionType = preChatData.autocorrectionType
        data?.isRequired = preChatData.isRequired
        data?.maxLength = UInt(preChatData.maxLength)
        data?.keyboardType = preChatData.keyboardType
        return data!
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        self.init(red: CGFloat((rgb >> 16) & 0xFF) / 255.0,
                  green: CGFloat((rgb >> 8) & 0xFF) / 255.0,
                  blue: CGFloat(rgb & 0xFF) / 255.0,
                  alpha: 1.0)
    }
}
