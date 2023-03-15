//
//  ChatConfig.swift
//  React-native-salesforce-chat-sdk
//
//  Created by Alex on 14/3/2023.
//

import Foundation
class ChatConfig {
    var liveAgentPod: String
    var orgId: String
    var deploymentId: String
    var buttonId: String
    
    init(liveAgentPod: String, orgId: String, deploymentId: String, buttonId: String) {
        self.liveAgentPod = liveAgentPod
        self.orgId = orgId
        self.deploymentId = deploymentId
        self.buttonId = buttonId
    }
    
    convenience init(dictionary: NSDictionary) {
        let liveAgentPod = dictionary["liveAgentPod"] as? String ?? ""
        let orgId = dictionary["orgId"] as? String ?? ""
        let deploymentId = dictionary["deploymentId"] as? String ?? ""
        let buttonId = dictionary["buttonId"] as? String ?? ""
        self.init(liveAgentPod: liveAgentPod, orgId: orgId, deploymentId: deploymentId, buttonId: buttonId)
    }
}
