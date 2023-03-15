//
//  displayConfig.swift
//  React-native-salesforce-chat-sdk
//
//  Created by Alex on 14/3/2023.
//

import Foundation
class DisplayConfig {
    var allowMinimization: Bool
    var allowURLPreview: Bool
    var defaultToMinimized: Bool
	var showPreChat: Bool
	var visitName: String
	
	init(allowMinimization: Bool, allowURLPreview: Bool, defaultToMinimized: Bool, showPreChat: Bool, visitName: String) {
        self.allowMinimization = allowMinimization
        self.allowURLPreview = allowURLPreview
        self.defaultToMinimized = defaultToMinimized
		self.showPreChat = showPreChat
		self.visitName = visitName
    }
    
    convenience init(dictionary: NSDictionary) {
        let allowMinimization = dictionary["allowMinimization"] as? Bool ?? false
        let allowURLPreview = dictionary["allowURLPreview"] as? Bool ?? false
        let defaultToMinimized = dictionary["defaultToMinimized"] as? Bool ?? false
		let showPreChat = dictionary["showPreChat"] as? Bool ?? false
		let visitName = dictionary["visitName"] as? String ?? ""
		
		self.init(allowMinimization: allowMinimization, allowURLPreview: allowURLPreview, defaultToMinimized: defaultToMinimized,showPreChat: showPreChat as! Bool ,visitName: visitName)
    }
}
