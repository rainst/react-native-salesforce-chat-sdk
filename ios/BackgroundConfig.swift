//
//  backgroundConfiguration.swift
//  React-native-salesforce-chat-sdk
//
//  Created by Alex on 14/3/2023.
//

import Foundation
class BackgroundConfig {
    var allowBackgroundExecution: Bool
    var allowBackgroundNotifications: Bool
    
    init(allowBackgroundExecution: Bool, allowBackgroundNotifications: Bool) {
        self.allowBackgroundExecution = allowBackgroundExecution
        self.allowBackgroundNotifications = allowBackgroundNotifications
    }
    
    convenience init(dictionary: NSDictionary) {
        let allowBackgroundExecution = dictionary["allowBackgroundExecution"] as? Bool ?? false
        let allowBackgroundNotifications = dictionary["allowBackgroundNotifications"] as? Bool ?? false
        self.init(allowBackgroundExecution: allowBackgroundExecution, allowBackgroundNotifications: allowBackgroundNotifications)
    }
}
