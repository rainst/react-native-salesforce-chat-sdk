import ServiceCore
import ServiceChat

@objc(SalesforceChatSdk)
class SalesforceChatSdk: RCTEventEmitter, SCSChatSessionDelegate {
	func session(_ session: SCSChatSession!, didError error: Error!, fatal: Bool) {
		sendEvent(withName: "onError", body: ["error",error.localizedDescription])
	}
	
	func session(_ session: SCSChatSession!, didTransitionFrom previous: SCSChatSessionState, to current: SCSChatSessionState) {
		
		switch current{
			case .connecting:
				sendEvent(withName: "onChatStateChanged", body: ["status":"connecting"])
			case .connected:
				sendEvent(withName: "onChatStateChanged", body:  ["status":"connected"])
			case .inactive:
				sendEvent(withName: "onChatStateChanged", body:  ["status":"inactive"])
			case .queued:
				sendEvent(withName: "onChatStateChanged", body:  ["status":"queued"])
			case .ending:
				sendEvent(withName: "onChatStateChanged", body:  ["status":"ending"])
			default:
				break
		}
	}
	
	func session(_ session: SCSChatSession!, didEnd endEvent: SCSChatSessionEndEvent!) {
		
		switch endEvent.reason {
			case .agent:
				sendEvent(withName: "onChatEnd", body: ["reason":"The agent has ended the session."])
			case .timeout:
				sendEvent(withName: "onChatEnd", body: ["reason":"timeout"])
			case .noAgentsAvailable:
				sendEvent(withName: "onChatEnd", body: ["reason":"No agents were available."])
			default:
				sendEvent(withName: "onChatEnd", body: ["reason":"Unknown"])
				break
		}
		
		
	}
	override func supportedEvents() -> [String]! {
		return ["onChatStateChanged","onChatEnd","onError"]
	}
	
	@objc(startChat:withDisplayConfig:withBackgroundConfig:withPreChatDatas:withPrechatEntitiesData:withResolver:withRejecter:)
	func startChat(chatConfig:NSDictionary,
				   displayConfig:NSDictionary,
				   backgroundConfig:NSDictionary,
				   preChatDatas:NSArray,
				   prechatEntitiesData:NSArray,
				   resolve: @escaping RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock)
	{
		ServiceCloud.shared().chatCore.add(delegate: self)
		let chatConfiguration = ChatConfig(dictionary: chatConfig)
		let displayConfiguration = DisplayConfig(dictionary: displayConfig)
		let backgroundConfiguration = BackgroundConfig(dictionary: backgroundConfig)
		if let config = SCSChatConfiguration(liveAgentPod: chatConfiguration.liveAgentPod,
											 orgId: chatConfiguration.orgId,
											 deploymentId:chatConfiguration.deploymentId ,
											 buttonId: chatConfiguration.buttonId){
			config.allowMinimization = displayConfiguration.allowMinimization
			config.allowURLPreview = displayConfiguration.allowURLPreview
			config.defaultToMinimized = displayConfiguration.defaultToMinimized
			config.allowBackgroundExecution = backgroundConfiguration.allowBackgroundExecution
			config.allowBackgroundNotifications = backgroundConfiguration.allowBackgroundNotifications
			config.visitorName = displayConfiguration.visitName
			for preChatData in preChatDatas {
                let element = PreChatField(dictionary: preChatData as! NSDictionary)
                if(element.fieldType == "Object"){
                    config.prechatFields.append(createPreChatField(preChatData: element))
                }else{
                    config.prechatFields.append(createPreChatTextInputField(preChatData: element))
                }
				
			}
			for prechatEntity in prechatEntitiesData {
				let entity = createPreChatEntity(prechatEntity: PreChatEntity(dictionary: prechatEntity as! NSDictionary)! )
				config.prechatEntities.append(entity)
			}
			
			DispatchQueue.main.async {
				print(displayConfiguration.showPreChat)
				ServiceCloud.shared().chatUI.showChat(with: config,showPrechat: displayConfiguration.showPreChat)
				resolve("opened")
			}
			
		}
	}
	
	@objc(closeChat:withRejecter:)
	func closeChat(resolve:@escaping RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock){
		DispatchQueue.main.async {
			ServiceCloud.shared().chatUI.dismissChat()
			resolve("done")
		}
		
	}
	
	@objc(setAppearance:withResolver:withRejecter:)
	func setAppearance(appearanceConfig:NSDictionary,resolve: @escaping RCTPromiseResolveBlock,reject: RCTPromiseRejectBlock){
		let appearance = SCAppearanceConfiguration()
		let appearanceConfiguration = Appearance(dict: appearanceConfig)
		if(appearanceConfiguration.navbarBackground != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.navbarBackground!)!, forName: .navbarBackground)
		}

		if(appearanceConfiguration.navbarInverted != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.navbarInverted!)!, forName: .navbarInverted)
		}
		
		if(appearanceConfiguration.brandPrimary != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.brandPrimary!)!, forName: .brandPrimary)
		}
		
		if(appearanceConfiguration.brandSecondary != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.brandSecondary!)!, forName: .brandSecondary)
		}
		
		if(appearanceConfiguration.brandPrimaryInverted != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.brandPrimaryInverted!)!, forName: .brandPrimaryInverted)
		}
		
		if(appearanceConfiguration.brandSecondaryInverted != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.brandSecondaryInverted!)!, forName: .brandSecondaryInverted)
		}
		
		if(appearanceConfiguration.contrastPrimary != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.contrastPrimary!)!, forName: .contrastPrimary)
		}
		
		if(appearanceConfiguration.contrastSecondary != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.contrastSecondary!)!, forName: .contrastSecondary)
		}
		
		if(appearanceConfiguration.contrastTertiary != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.contrastTertiary!)!, forName: .contrastTertiary)
		}
		
		if(appearanceConfiguration.contrastQuaternary != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.contrastQuaternary!)!, forName: .contrastQuaternary)
		}
		
		if(appearanceConfiguration.contrastInverted != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.contrastInverted!)!, forName: .contrastInverted)
		}
		
		if(appearanceConfiguration.feedbackPrimary != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.feedbackPrimary!)!, forName: .feedbackPrimary)
		}
		
		if(appearanceConfiguration.feedbackSecondary != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.feedbackSecondary!)!, forName: .feedbackSecondary)
		}
		if(appearanceConfiguration.feedbackTertiary != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.feedbackTertiary!)!, forName: .feedbackTertiary)
		}
		if(appearanceConfiguration.overlay != nil){
			appearance.setColor(UIColor(hex: appearanceConfiguration.overlay!)!, forName: .overlay)
		}
        
		DispatchQueue.main.async {
			ServiceCloud.shared().appearanceConfiguration = appearance
			resolve("done")
		}
	}
	
}


