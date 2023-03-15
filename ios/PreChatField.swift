//
//  PrechatField.swift
//  React-native-salesforce-chat-sdk
//
//  Created by Alex on 14/3/2023.
//

import Foundation
class PreChatField {
    var initialValue: String
    var autocapitalizationType: UITextAutocapitalizationType
    var autocorrectionType: UITextAutocorrectionType
    var isRequired: Bool
    var maxLength: Int
    var keyboardType: UIKeyboardType
    var label: String
    var fieldType:String
    
    init(initialValue: String, autocapitalizationType: UITextAutocapitalizationType, autocorrectionType: UITextAutocorrectionType, isRequired: Bool, maxLength: Int, keyboardType: UIKeyboardType, label: String, fieldType:String) {
        self.initialValue = initialValue
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.isRequired = isRequired
        self.maxLength = maxLength
        self.keyboardType = keyboardType
        self.label = label
        self.fieldType = fieldType
    }
    
    convenience init(dictionary: NSDictionary) {
        let initialValue = dictionary["initialValue"] as? String ?? ""
        let fieldType = dictionary["fieldType"] as? String ?? ""
        let autocapitalizationTypeValue = dictionary["autocapitalizationType"] as? Int ?? 0
        let autocapitalizationType = UITextAutocapitalizationType(rawValue: autocapitalizationTypeValue) ?? .none
        let autocorrectionTypeValue = dictionary["autocorrectionType"]  as? Int ?? 0
        let autocorrectionType = UITextAutocorrectionType(rawValue: autocorrectionTypeValue) ?? .default
        let isRequired = dictionary["isRequired"] as? Bool ?? false
        let maxLength = dictionary["maxLength"] as? Int ?? 50
        let keyboardTypeValue = dictionary["keyboardType"] as? Int ?? 0
        let keyboardType = UIKeyboardType(rawValue: keyboardTypeValue) ?? .default
        let label = dictionary["label"] as? String ?? ""
        self.init(initialValue: initialValue, autocapitalizationType: autocapitalizationType, autocorrectionType: autocorrectionType, isRequired: isRequired, maxLength: maxLength, keyboardType: keyboardType, label: label,fieldType: fieldType)
    }
}
